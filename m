Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E832EA7CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jan 2021 10:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbhAEJoy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jan 2021 04:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbhAEJox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jan 2021 04:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609839807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/pf3MEGHy4BVUnm30O0L31xAu34MGBgOtsz0A/Rhcg=;
        b=FE/DXC8xHpjD+8OfnjM2F8BqdLKeb5bwdHNlIXpk8l3jptUE9StZP6syJoUd+oCAL5dqdL
        s9AxcIh5XTUUUrlWEa7dMCrhjhzQpENGNBnT4V2WYlfGOxiLaCVqbDDcaoeLRNYBOo5y+A
        rCXO1SXZdyObPv+9neSgBN2PQvGZeE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-eV-NK1QRM5yLiP4y727A1Q-1; Tue, 05 Jan 2021 04:43:23 -0500
X-MC-Unique: eV-NK1QRM5yLiP4y727A1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA59310054FF;
        Tue,  5 Jan 2021 09:43:21 +0000 (UTC)
Received: from yiche-home.usersys.redhat.com (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C307E62463;
        Tue,  5 Jan 2021 09:43:18 +0000 (UTC)
From:   Yi Chen <yiche@redhat.com>
To:     Chen Yi <yiche@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Leo <liuhangbin@gmail.com>
Subject: [PATCHv2 net] selftests: netfilter: Pass the family parameter to conntrack tool
Date:   Tue,  5 Jan 2021 17:43:16 +0800
Message-Id: <20210105094316.23683-1-yiche@redhat.com>
In-Reply-To: <20210104110723.43564-1-yiche@redhat.com>
References: <20210104110723.43564-1-yiche@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: yiche <yiche@redhat.com>

Fixes: 619ae8e0697a6 ("selftests: netfilter: add test case for conntrack helper assignment")

Fix nft_conntrack_helper.sh fake fail:
conntrack tool need "-f ipv6" parameter to show out ipv6 traffic items.
sleep 1 second after background nc send packet, to make sure check
is after this statement executed.

Signed-off-by: yiche <yiche@redhat.com>
---
 .../selftests/netfilter/nft_conntrack_helper.sh      | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/netfilter/nft_conntrack_helper.sh b/tools/testing/selftests/netfilter/nft_conntrack_helper.sh
index edf0a48da6bf..bf6b9626c7dd 100755
--- a/tools/testing/selftests/netfilter/nft_conntrack_helper.sh
+++ b/tools/testing/selftests/netfilter/nft_conntrack_helper.sh
@@ -94,7 +94,13 @@ check_for_helper()
 	local message=$2
 	local port=$3
 
-	ip netns exec ${netns} conntrack -L -p tcp --dport $port 2> /dev/null |grep -q 'helper=ftp'
+	if echo $message |grep -q 'ipv6';then
+		local family="ipv6"
+	else
+		local family="ipv4"
+	fi
+
+	ip netns exec ${netns} conntrack -L -f $family -p tcp --dport $port 2> /dev/null |grep -q 'helper=ftp'
 	if [ $? -ne 0 ] ; then
 		echo "FAIL: ${netns} did not show attached helper $message" 1>&2
 		ret=1
@@ -111,8 +117,8 @@ test_helper()
 
 	sleep 3 | ip netns exec ${ns2} nc -w 2 -l -p $port > /dev/null &
 
-	sleep 1
 	sleep 1 | ip netns exec ${ns1} nc -w 2 10.0.1.2 $port > /dev/null &
+	sleep 1
 
 	check_for_helper "$ns1" "ip $msg" $port
 	check_for_helper "$ns2" "ip $msg" $port
@@ -128,8 +134,8 @@ test_helper()
 
 	sleep 3 | ip netns exec ${ns2} nc -w 2 -6 -l -p $port > /dev/null &
 
-	sleep 1
 	sleep 1 | ip netns exec ${ns1} nc -w 2 -6 dead:1::2 $port > /dev/null &
+	sleep 1
 
 	check_for_helper "$ns1" "ipv6 $msg" $port
 	check_for_helper "$ns2" "ipv6 $msg" $port
-- 
2.26.2

