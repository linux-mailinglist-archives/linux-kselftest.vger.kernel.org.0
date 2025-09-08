Return-Path: <linux-kselftest+bounces-40941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C065FB48E03
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 14:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7EC34E1A4C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47AE3054C6;
	Mon,  8 Sep 2025 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmYn5GTx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6E30504D
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335684; cv=none; b=tLBLf5SQddhAtnFh4jhPONtVLDXvjg/2kKHjv6J8i+EoX6ilatPi9llq4wXXXPFWDBfG2qFaenlAHveXyOg8zo02aBXhnS2kz94Vlr7p9SW7jLnzrINZ6r/s4uaNL+2QSm3yij8SI04bFFAlDWADYWJUeonsU7kNxFOEsvurLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335684; c=relaxed/simple;
	bh=i6ORQKi78daQiWjOQKNRw7LJCVz6f/Qp7x5vLgWL548=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6iGEnhKQwSiibSAVZgv9wumKDZA1sq8/14v/A4UvMyLnUXTjnkVRyd6O+P8pBi3fHHiJZ7+L4B0WSK5uLTk7iqQYwoei7REopr/VsQKYKZR/vv2XviYGFBo3Ulu9nkrhMNJ96L8ax4MsOCQrzdvNRmZoMo4dTujRckV6c08ePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmYn5GTx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757335681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vWpjrE0Rlrrkbvt+KoFLxj2HD6byoInImyP0llvmto=;
	b=AmYn5GTxfsaz4kWbVFHyUvx5cAeO6SLI1fel6UFuC30VB1+StU1pqaE0Z8q/3aOxUmYIJB
	J/EsF+MX24WD7Rt7IwNOyu1Eg6BhWpVMBPEO7pzR7bsmZNSf9v/pfwW+6uDC5goTmlenSN
	DXN7ZLPNVMLr843WZDJMkuLgKRpQSmQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-sZyIc_KXMIabhP0a0tqncg-1; Mon,
 08 Sep 2025 08:47:59 -0400
X-MC-Unique: sZyIc_KXMIabhP0a0tqncg-1
X-Mimecast-MFC-AGG-ID: sZyIc_KXMIabhP0a0tqncg_1757335677
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 447971800357;
	Mon,  8 Sep 2025 12:47:57 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76FFE300018D;
	Mon,  8 Sep 2025 12:47:51 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org,
	linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	chuhu@redhat.com
Subject: [PATCH v2 1/3] selftests/mm: fix hugepages cleanup too early
Date: Mon,  8 Sep 2025 20:47:37 +0800
Message-ID: <20250908124740.2946005-2-chuhu@redhat.com>
In-Reply-To: <20250908124740.2946005-1-chuhu@redhat.com>
References: <20250908124740.2946005-1-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The nr_hugepgs variable is used to keep the original nr_hugepages at the
hugepage setup step at test beginning. After userfaultfd test, a cleaup is
executed, both /sys/kernel/mm/hugepages/hugepages-*/nr_hugepages and
/proc/sys//vm/nr_hugepages are reset to 'original' value before userfaultfd
test starts.

Issue here is the value used to restore /proc/sys/vm/nr_hugepages is
nr_hugepgs which is the initial value before the vm_runtests.sh runs, not
the value before userfaultfd test starts. 'va_high_addr_swith.sh' tests
runs after that will possibly see no hugepages available for test, and got
EINVAL when mmap(HUGETLB), making the result invalid.

And before pkey tests, nr_hugepgs is changed to be used as a temp variable
to save nr_hugepages before pkey test, and restore it after pkey tests
finish. The original nr_hugepages value is not tracked anymore, so no way
to restore it after all tests finish.

Add a new variable orig_nr_hugepgs to save the original nr_hugepages, and
and restore it to nr_hugepages after all tests finish. And change to use
the nr_hugepgs variable to save the /proc/sys/vm/nr_hugeages after hugepage
setup, it's also the value before userfaultfd test starts, and the correct
value to be restored after userfaultfd finishes. The va_high_addr_switch.sh
broken will be resolved.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>

---
Changes in v2
 - rename nr_hugepgs_origin to orig_nr_hugepgs
---
 tools/testing/selftests/mm/run_vmtests.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 471e539d82b8..9866e4221bc2 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -172,13 +172,13 @@ fi
 
 # set proper nr_hugepages
 if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
-	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
+	orig_nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
 	needpgs=$((needmem_KB / hpgsize_KB))
 	tries=2
 	while [ "$tries" -gt 0 ] && [ "$freepgs" -lt "$needpgs" ]; do
 		lackpgs=$((needpgs - freepgs))
 		echo 3 > /proc/sys/vm/drop_caches
-		if ! echo $((lackpgs + nr_hugepgs)) > /proc/sys/vm/nr_hugepages; then
+		if ! echo $((lackpgs + orig_nr_hugepgs)) > /proc/sys/vm/nr_hugepages; then
 			echo "Please run this test as root"
 			exit $ksft_skip
 		fi
@@ -189,6 +189,7 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 		done < /proc/meminfo
 		tries=$((tries - 1))
 	done
+	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
 	if [ "$freepgs" -lt "$needpgs" ]; then
 		printf "Not enough huge pages available (%d < %d)\n" \
 		       "$freepgs" "$needpgs"
@@ -532,6 +533,10 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh aligned
 
 CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
 
+if [ "${HAVE_HUGEPAGES}" = 1 ]; then
+	echo "$orig_nr_hugepgs" > /proc/sys/vm/nr_hugepages
+fi
+
 echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
 echo "1..${count_total}" | tap_output
 
-- 
2.49.0


