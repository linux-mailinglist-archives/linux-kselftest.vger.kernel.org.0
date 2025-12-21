Return-Path: <linux-kselftest+bounces-47780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA04CD3B14
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 04:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2029730014E9
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 03:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D01823DD;
	Sun, 21 Dec 2025 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfhHSS/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28C46B5
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766287516; cv=none; b=onuGS5smYjwQ/IWDEzcH1iPIOJ5cHxEPr82fw/x0GV2s7xPTT1VdUHlaZg5aMvll4gaSuj2sNKh6DhaOji4RGklB7w8rHuVSa+9iWMQGQ2NAEo5/pDSajTh9tS18BEYV1sNllhbucRcEAytWT4Zj8Dic/yCHLElR9wmMey/TpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766287516; c=relaxed/simple;
	bh=ChRqOFaf31YjVsEZri0GUp4ODsUr1TszRt5WE+4HAIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7PZLfBOQm1+vVMaYItFgDVBT6qGNwoGLlV1NFUQMzbBWFRQVC+/WJJAZJ74xjO51tYk5TlXs4FE7kNpgsuLmLgirydKHjffDggxuFp21x7aqPahEKWCPWfcRggfOrOjLQAYiSudvpa66rf70vAdTSObpwvUhflAZ00vA5XP3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfhHSS/z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766287513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpOhK118LaDWKm765ndboJZL+xQDVhQwHQhCepJJnh8=;
	b=hfhHSS/zpsz3MSY55Xt5/7ctEtk3f+0eLJ0b6di3KsoYKBr5TdXBpAlwfNeEFEcBVklgUQ
	p4s0WmRmFmyvRLB5Sh4oOcjpBTuFwPDsXZ1ouaaoP/YpP9sHw1HUINrnm5L3tqAYNWzSDs
	4rlowBILUxgOLMFFgrmxgFyZKV0E3f4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-1PfFEtf5P3CDFsRYVvXxsw-1; Sat,
 20 Dec 2025 22:25:09 -0500
X-MC-Unique: 1PfFEtf5P3CDFsRYVvXxsw-1
X-Mimecast-MFC-AGG-ID: 1PfFEtf5P3CDFsRYVvXxsw_1766287507
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C216180035A;
	Sun, 21 Dec 2025 03:25:07 +0000 (UTC)
Received: from gmail.com (unknown [10.72.112.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B09311955F1A;
	Sun, 21 Dec 2025 03:24:59 +0000 (UTC)
Date: Sun, 21 Dec 2025 11:24:52 +0800
From: Chunyu Hu <chuhu@redhat.com>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: akpm@linux-foundation.org, david@kernel.org, shuah@kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com
Subject: Re: [PATCH v1 1/3] selftests/mm: fix va_high_addr_switch.sh return
 value
Message-ID: <aUdohHjAfaYmjH3a@gmail.com>
References: <20251207122239.3228920-1-chuhu@redhat.com>
 <f8d1e504-2009-4bd6-b1b7-c98c1f49374a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8d1e504-2009-4bd6-b1b7-c98c1f49374a@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Dec 08, 2025 at 10:44:45AM -0500, Luiz Capitulino wrote:
> On 2025-12-07 07:22, Chunyu Hu wrote:
> > Patch series "Fix va_high_addr_switch.sh test failure - again", v1.
> > 
> > There are two issues exist for the  va_high_addr_switch test. One issue is
> > the test return value is ignored in va_high_addr_switch.sh. The second is
> > the va_high_addr_switch requires 6 hugepages but it requires 5.
> > 
> > Besides that, the nr_hugepages setup in run_vmtests.sh for arm64 can be
> > done in va_high_addr_switch.sh too.
> > 
> > This patch: (of 3)
> > 
> > The return value should be return value of va_high_addr_switch, otherwise
> > a test failure would be silently ignored.
> > 
> > Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
> > CC: Luiz Capitulino <luizcap@redhat.com>
> > Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> 
> This fix is good, but there are two additional issues that need fixing
> (maybe in separate patches):
> 
> 1. In main() we do:
> 
> """
>         ret = run_test(testcases, sz_testcases);
>         if (argc == 2 && !strcmp(argv[1], "--run-hugetlb"))
>                 ret = run_test(hugetlb_testcases, sz_hugetlb_testcases);
> """
> 
> The second run_test() overwrites the return code of the first one, so if
> the first fails and the second one succeeds, the test will report
> success.

Good catch. I can add a fix for this in v2.

> 
> 2. The following comment in va_high_addr_switch.sh is wrong in two
> counts: there's an eligibility check for powerpc64 and the test doesn't
> reject other architectures as it runs on arm64 as well.
> 
> """
>     # The test supports x86_64 and powerpc64. We currently have no useful
>     # eligibility check for powerpc64, and the test itself will reject other
>     # architectures.
> """

I can update the comment in v2.

> 
> For this fix:
> 
> Reviewed-by: Luiz Capitulino <luizcap@redhat.com>
> 
> > ---
> >   tools/testing/selftests/mm/va_high_addr_switch.sh | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
> > index a7d4b02b21dd..f89fe078a8e6 100755
> > --- a/tools/testing/selftests/mm/va_high_addr_switch.sh
> > +++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
> > @@ -114,4 +114,6 @@ save_nr_hugepages
> >   # 4 keep_mapped pages, and one for tmp usage
> >   setup_nr_hugepages 5
> >   ./va_high_addr_switch --run-hugetlb
> > +retcode=$?
> >   restore_nr_hugepages
> > +exit $retcode
> 
> 
> 
> 
> 
> 
> 
> 
> 


