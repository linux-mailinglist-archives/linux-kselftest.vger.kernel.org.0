Return-Path: <linux-kselftest+bounces-13061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DA3923EFA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 15:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF25C28A1F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949DB1BA06A;
	Tue,  2 Jul 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqt3CBra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B41B5800
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926954; cv=none; b=rQjV4V0fnxCatDOtMbvtE9yreB7AekGLwjY0iijibO+65EzTkEagnSYWyQ81G6HVvZqVN+m+bvWtTr998hmB0hfjObPr+F4+TrhDnmeZhVoBvXAQa0iB1iex0U1qQuOSrQA9PrUG/r6Lxfnqkmjf++1Jc5emgLAnqSbyt3TsA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926954; c=relaxed/simple;
	bh=Md4OIEI8Xk4k+u3H0ICjhfnaCqEai/wBrcFngDWAWZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0//RL2CvLsf4SXoaoM62+hbVmT6Pyf66W236Wx8hKdvOoHhJP+90zhoGuomyciTyOGFh2yvEVVofctog+CBqpjW92pjGjAjoywGkLQ35lREpY2VnCVIWSv8qI30RaOcYggtIU06kV17JOrvNVP2CXHJbNGGFgLWxIJdn/V65ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqt3CBra; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719926952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giGzfHbFvw5ELOoh3gsT5u4QyGdGlB0ujxo9yyHMwqU=;
	b=hqt3CBraueW6fXv5G6WfvDsvcF/EkHCopaEs7c+5+EupvJKHbKbqqZwrWH+7iwkt9yRjAC
	Gj+ZmuYfLyoC/S4QY7kGxJLkIQrpgJI8gCZiZwyU5bJX6UbzB7Wy4yLgRVdYFdd9i1J47M
	F1K1OqHL/ZZCgxcSYgVI1zUL/+pHvHI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-THrynPfCOsqyX_eyscvuzw-1; Tue,
 02 Jul 2024 09:29:08 -0400
X-MC-Unique: THrynPfCOsqyX_eyscvuzw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 981261944DEC;
	Tue,  2 Jul 2024 13:29:06 +0000 (UTC)
Received: from RHTRH0061144.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6737019815C1;
	Tue,  2 Jul 2024 13:28:49 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 3/3] selftests: openvswitch: Be more verbose with selftest debugging.
Date: Tue,  2 Jul 2024 09:28:30 -0400
Message-ID: <20240702132830.213384-4-aconole@redhat.com>
In-Reply-To: <20240702132830.213384-1-aconole@redhat.com>
References: <20240702132830.213384-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The openvswitch selftest is difficult to debug for anyone that isn't
directly familiar with the openvswitch module and the specifics of the
test cases.  Many times when something fails, the debug log will be
sparsely populated and it takes some time to understand where a failure
occured.

Increase the amount of details logged to the debug log by trapping all
'info' logs, and all 'ovs_sbx' commands.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
NOTE: There is a conflict here with a patch on list that adds psample
      support, but it should be simple to resolve, since the conflict
      would be due to a context change in tests="".  I can also respin
      if the patches collide.

 tools/testing/selftests/net/openvswitch/openvswitch.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 0bd0425848d9..531951086d9c 100755
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
@@ -139,7 +142,7 @@ ovs_add_flow () {
 	info "Adding flow to DP: sbx:$1 br:$2 flow:$3 act:$4"
 	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py add-flow "$2" "$3" "$4"
 	if [ $? -ne 0 ]; then
-		echo "Flow [ $3 : $4 ] failed" >> ${ovs_dir}/debug.log
+		info "Flow [ $3 : $4 ] failed"
 		return 1
 	fi
 	return 0
-- 
2.45.1


