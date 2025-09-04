Return-Path: <linux-kselftest+bounces-40785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 105BAB43FAA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6368C1888052
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19E1EEA55;
	Thu,  4 Sep 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP2sT/EA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866915746F
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997565; cv=none; b=r1XflU5vsMboazGMyEXY6Q9AyrLnOgF6RECsu+TURo5QqoAE/QzSBWbSJb6QlVgz6Sfr0lBLCci1PfCeR9yabKOziznSAnzdYeEXYpp3fuDZT0axcDSxE6QvHbHkgjt/zZy/f06cjRBPywglwZP9JdQyBYtIjcMJ4HId+zHIZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997565; c=relaxed/simple;
	bh=D561VjwYH9RA6r2Rugv4ZQ4heaNI4ENsoElZA2pFl7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0cp3Qnet7/cU0aE0bNLogfR5YPelR9XLcsm8bkUA1jOW74kbwXKz+PXhONaRO5pqyeDWRg4MqIX1pX1RXjnF2b8b/RGh6UG7rYj0WfkGMLReRgb5ZyccOm+fLPrXIEMDfsVLxwbyW0rSpTcP56PFZXruc++KfImdhwgZYDWsDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP2sT/EA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756997562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BazxnC+Wcptnkdd+tPophW9XIDvM64THaSvkRAFx9Mg=;
	b=VP2sT/EAUXPlLqopVQROh9M94Ion1zcudzMoJnrel8N+jIfL1KCXIxEfFDFMPx021vVhKV
	11a/AjixhxvrzFLjTiaMWRw2bZz6sUwc0yuPsTF9sVn4wFR0erR7nIGlNe82Uzkd0o7Nd+
	2RXp0vxtKXVDNTEbED+VOsrdKfLXulY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-1O0OaGzTPK-kKLpbyr87uA-1; Thu,
 04 Sep 2025 10:52:39 -0400
X-MC-Unique: 1O0OaGzTPK-kKLpbyr87uA-1
X-Mimecast-MFC-AGG-ID: 1O0OaGzTPK-kKLpbyr87uA_1756997556
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 631281800291;
	Thu,  4 Sep 2025 14:52:36 +0000 (UTC)
Received: from gmail.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C81361955F24;
	Thu,  4 Sep 2025 14:52:29 +0000 (UTC)
Date: Thu, 4 Sep 2025 22:52:25 +0800
From: Chunyu Hu <chuhu@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com
Subject: [RESEND] Re: [PATCH 1/2] selftests/mm: fix hugepages cleanup too
 early
Message-ID: <aLmnqYrAaa4MrZZA@gmail.com>
References: <20250827075209.2347015-1-chuhu@redhat.com>
 <20250827075209.2347015-2-chuhu@redhat.com>
 <87956f34-e6b0-4d03-b30e-56be4f6b84f1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87956f34-e6b0-4d03-b30e-56be4f6b84f1@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Aug 27, 2025 at 01:41:34PM +0200, David Hildenbrand wrote:
> On 27.08.25 09:52, Chunyu Hu wrote:
> > The nr_hugepgs variable is used to keep the original nr_hugepages at the
> > hugepage setup step at test beginning. After userfaultfd test, a cleaup is
> > executed, both /sys/kernel/mm/hugepages/hugepages-*/nr_hugepages and
> > /proc/sys//vm/nr_hugepages are reset to 'original' value before userfaultfd
> > test starts.
> > 
> > Issue here is the value used to restore /proc/sys/vm/nr_hugepages is
> > nr_hugepgs which is the initial value before the vm_runtests.sh runs, not
> > the value before userfaultfd test starts. 'va_high_addr_swith.sh' tests
> > runs after that will possibly see no hugepages available for test, and got
> > EINVAL when mmap(HUGETLB), making the result invalid.
> > 
> > And before pkey tests, nr_hugepgs is changed to be used as a temp variable
> > to save nr_hugepages before pkey test, and restore it after pkey tests
> > finish. The original nr_hugepages value is not tracked anymore, so no way
> > to restore it after all tests finish.
> > 
> > Add a new variable nr_hugepgs_origin to save the original nr_hugepages, and
> > and restore it to nr_hugepages after all tests finish. And change to use
> > the nr_hugepgs variable to save the /proc/sys/vm/nr_hugeages after hugepage
> > setup, it's also the value before userfaultfd test starts, and the correct
> > value to be restored after userfaultfd finishes. The va_high_addr_switch.sh
> > broken will be resolved.
> > 
> > Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> > ---
> >   tools/testing/selftests/mm/run_vmtests.sh | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> > index 471e539d82b8..f1a7ad3ec6a7 100755
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -172,13 +172,13 @@ fi
> >   # set proper nr_hugepages
> >   if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
> > -	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
> > +	nr_hugepgs_origin=$(cat /proc/sys/vm/nr_hugepages)
> 
> I'd call this "orig_nr_hugepgs".

[RESEND to add back the unexpectedly dropped mail list, sorry for that]

Hi David,

Thank you for your review and valuable feedback. I will rename it with
a v2 and resend the two patches. 

> 
> But it's a shame that the naming is then out of sync with nr_size_hugepgs?

nr_size_hugepgs is for uffd-wp-mremap, the test need all sizes hugepages,
it's used to save and restore the nr_hugepagees of all sizes of hugepages,
it's a test case setup, not like nr_hugepgs which is a global/general
setup.
They are not the same kind, maybe they don't need to be aligned.


> 
> 
> >   	needpgs=$((needmem_KB / hpgsize_KB))
> >   	tries=2
> >   	while [ "$tries" -gt 0 ] && [ "$freepgs" -lt "$needpgs" ]; do
> >   		lackpgs=$((needpgs - freepgs))
> >   		echo 3 > /proc/sys/vm/drop_caches
> > -		if ! echo $((lackpgs + nr_hugepgs)) > /proc/sys/vm/nr_hugepages; then
> > +		if ! echo $((lackpgs + nr_hugepgs_origin)) > /proc/sys/vm/nr_hugepages; then
> >   			echo "Please run this test as root"
> >   			exit $ksft_skip
> >   		fi
> > @@ -189,6 +189,7 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
> >   		done < /proc/meminfo
> >   		tries=$((tries - 1))
> >   	done
> > +	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
> >   	if [ "$freepgs" -lt "$needpgs" ]; then
> >   		printf "Not enough huge pages available (%d < %d)\n" \
> >   		       "$freepgs" "$needpgs"
> > @@ -532,6 +533,10 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh aligned
> >   CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
> > +if [ "${HAVE_HUGEPAGES}" = 1 ]; then
> > +	echo "$nr_hugepgs_origin" > /proc/sys/vm/nr_hugepages
> > +fi
> 
> FWIW, I think the tests should maybe be doing that (save+configure+restore)
> themselves, like we do with THP settings through.
> 
> thp_save_settings()
> thp_write_settings()
> 
> and friends.

For this va_high_addr_switch test, looks like we can do the save_setting,
write_setting and restore_setting in the va_high_addr_switch.sh.

> 
> This is not really something run_vmtests.sh should bother with.
> 
> A bigger rework, though ...

Totally agree, with the c interface to do that is better. then the
vm_runtest.sh would  be clean. It's a bigger rework outside of this topic.

> 
> -- 
> Cheers
> 
> David / dhildenb
> 


