Return-Path: <linux-kselftest+bounces-4861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F5B858144
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 16:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FDAB21D3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A013B28A;
	Fri, 16 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP+OhD2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9DC12F39F
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097336; cv=none; b=dLuoXRBYyJj37t50Zu6aVJQXVpAaKrqe/EM3q5SlaR271vYXu22FjnWCcI9UG9LRjq4sympAVDJ26KAVcoahPKGCLF3fDxlpq0XU9X42NFD8dIZLJixDTAyfW30PU7Xd6fZv4lnLDGiOSrmb98k37/RecohtNRom9kxBgycYsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097336; c=relaxed/simple;
	bh=PIMA86KyXaitvSyuuTjXRvneAlVtthQAw7PLEDbmb0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd6L2IWRpNPBrkQP05HgvZW8xjKmBw5QpQPBCk4iJjI78JyqxMUryw1Yp3tGnIPnDFsNNellCgya/+BaOIuy7OClR8g56MxL/9vfEW70ifs95gcPFCT0Py2TeDKvErK9YUHqjPVW70tmOHPCnUDpvclSss04SkCNv8ymgv4hCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MP+OhD2+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708097334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddA7zwUE8jz8+b5sol2qfCRq18570UeGwF1LeSkNhuk=;
	b=MP+OhD2+2tGpmPa/Uok5axf39Ymz6Ys3qDXT7WeIx7oU/V67Pmdy9tgUguS07c7qd2zxIH
	JyzIi40M11CxjjzELlas3fve+HF54OVidxZa6IJAmy04VnNBtwlCGZNbcTtBU9m2WaI6XF
	2pg5ZCOJu6fLKNkbavmdNty4n2slo4o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-cleYxLT9OSSy96xXZmVwGQ-1; Fri, 16 Feb 2024 10:28:49 -0500
X-MC-Unique: cleYxLT9OSSy96xXZmVwGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E54BA108C062;
	Fri, 16 Feb 2024 15:28:48 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 691F31C060B1;
	Fri, 16 Feb 2024 15:28:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC 2/7] selftests: openvswitch: be more verbose with selftest debugging
Date: Fri, 16 Feb 2024 10:28:41 -0500
Message-ID: <20240216152846.1850120-3-aconole@redhat.com>
In-Reply-To: <20240216152846.1850120-1-aconole@redhat.com>
References: <20240216152846.1850120-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

The openvswitch selftest is difficult to debug for anyone that isn't
directly familiar with the openvswitch module and the specifics of the
test cases.  Many times when something fails, the debug log will be
sparsely populated and it takes some time to understand where a failure
occured.

Increase the amount of details logged to the debug log by trapping all
'info' logs, and all 'ovs_sbx' commands.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/openvswitch.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 87b80bee6df4..a5dbde482ba4 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -23,7 +23,9 @@ tests="
 	drop_reason				drop: test drop reasons are emitted"
 
 info() {
-    [ $VERBOSE = 0 ] || echo $*
+	[ "${ovs_dir}" != "" ] &&
+		echo "`date +"[%m-%d %H:%M:%S]"` $*" >> ${ovs_dir}/debug.log
+	[ $VERBOSE = 0 ] || echo $*
 }
 
 ovs_base=`pwd`
@@ -65,7 +67,8 @@ ovs_setenv() {
 
 ovs_sbx() {
 	if test "X$2" != X; then
-		(ovs_setenv $1; shift; "$@" >> ${ovs_dir}/debug.log)
+		(ovs_setenv $1; shift;
+		 info "run cmd: $@"; "$@" >> ${ovs_dir}/debug.log)
 	else
 		ovs_setenv $1
 	fi
@@ -139,9 +142,10 @@ ovs_add_flow () {
 	info "Adding flow to DP: sbx:$1 br:$2 flow:$3 act:$4"
 	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py add-flow "$2" "$3" "$4"
 	if [ $? -ne 0 ]; then
-		echo "Flow [ $3 : $4 ] failed" >> ${ovs_dir}/debug.log
+		info "Flow [ $3 : $4 ] failed"
 		return 1
 	fi
+	info "Flow added."
 	return 0
 }
 
-- 
2.41.0


