Return-Path: <linux-kselftest+bounces-4888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA41858A51
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 00:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B5B1C22416
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 23:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B9014A0AC;
	Fri, 16 Feb 2024 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="U8q5O9Nj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DA1DFFD;
	Fri, 16 Feb 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127415; cv=none; b=brLhDCk8giyKpWX1yjduOCP3dhNgemCpoHX/mvTc1VDGqPZ56w2jBXMT0/vckE1nc8TNQcgxw+rEdUzHm1s+mSNCoJcdmiFY3LEgMuDtvjz59d7GLRSKNXqz4fUgCXwpfeakZycgayJDSaKHR0dvejpCFIf8sutaFt8OVDAl17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127415; c=relaxed/simple;
	bh=J8FXU7aHYZuODWspt2kUR8S1w28W8VmvUfgLuCM8cWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRURKYdqKzyF71Qn2uUDRREZMF3jIFR9IIQYXhMsKjt4TkvBf8KS5aGY5/KIkr0VFS5UrbOdoGfPsrH+hNtXvqN9kk4H2GDH+CD0We8xhM7Feheafx1Aim4/Kv/y9UXc8pagHCsXHaq7p4vdJmehSJFFOI8S71qMECXMOjJApcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=U8q5O9Nj; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id BF415200C992;
	Sat, 17 Feb 2024 00:44:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be BF415200C992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708127066;
	bh=9j5eVpiBwzw5ltDCPFe2hsyvQP/Xgv6qbYI20MohXf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8q5O9Nj59vvVIzHuQFzN6OH7r3zRtBcokHLHAk+64iTZhAE6Wiz0fjNTOddW/08f
	 9r0E4ZzyNbnjPQG/4LfgnSbUD+6fJt92s7Rjm1tYU35KQ4MJI3g3rI/1Cmug9SVyTZ
	 4kNIO1UyGNnLTiL5VoIO6f90asrlslLJ3RPFtL6Ztzv0Nrls6KOAno/PcC76TjNRJq
	 gQCPgyvxxKh6GCceCbDVIu6sCKjAh3iDqqCOngJyALFaPc3AhJLaTb5L2Qj7w/WaoW
	 bTnhAkNlKZSzrK7Xd3J97T7aXa1/akCwDp6Ztd2FeXc/6MGgN4G0s7sql9pcyPXJa0
	 fAOUjAkzxvU+Q==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net 2/2] selftests: ioam6: refactoring to align with the fix
Date: Sat, 17 Feb 2024 00:43:56 +0100
Message-Id: <20240216234356.32243-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216234356.32243-1-justin.iurman@uliege.be>
References: <20240216234356.32243-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioam6_parser uses a packet socket. After the fix to prevent writing to
cloned skb's, the receiver does not see its IOAM data anymore, which
makes input/forward ioam-selftests to fail. As a workaround,
ioam6_parser now uses an IPv6 raw socket and leverages ancillary data to
get hop-by-hop options. As a consequence, the hook is "after" the IOAM
data insertion by the receiver and all tests are working again.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 tools/testing/selftests/net/ioam6.sh       |  38 ++++----
 tools/testing/selftests/net/ioam6_parser.c | 101 +++++++++++----------
 2 files changed, 73 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
index fe59ca3e5596..12491850ae98 100755
--- a/tools/testing/selftests/net/ioam6.sh
+++ b/tools/testing/selftests/net/ioam6.sh
@@ -367,14 +367,12 @@ run_test()
   local desc=$2
   local node_src=$3
   local node_dst=$4
-  local ip6_src=$5
-  local ip6_dst=$6
-  local if_dst=$7
-  local trace_type=$8
-  local ioam_ns=$9
-
-  ip netns exec $node_dst ./ioam6_parser $if_dst $name $ip6_src $ip6_dst \
-         $trace_type $ioam_ns &
+  local ip6_dst=$5
+  local trace_type=$6
+  local ioam_ns=$7
+  local type=$8
+
+  ip netns exec $node_dst ./ioam6_parser $name $trace_type $ioam_ns $type &
   local spid=$!
   sleep 0.1
 
@@ -489,7 +487,7 @@ out_undef_ns()
          trace prealloc type 0x800000 ns 0 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0x800000 0
+         db01::1 0x800000 0 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -509,7 +507,7 @@ out_no_room()
          trace prealloc type 0xc00000 ns 123 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xc00000 123
+         db01::1 0xc00000 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -543,14 +541,14 @@ out_bits()
       if [ $cmd_res != 0 ]
       then
         npassed=$((npassed+1))
-        log_test_passed "$descr"
+        log_test_passed "$descr ($1 mode)"
       else
         nfailed=$((nfailed+1))
-        log_test_failed "$descr"
+        log_test_failed "$descr ($1 mode)"
       fi
     else
 	run_test "out_bit$i" "$descr ($1 mode)" $ioam_node_alpha \
-           $ioam_node_beta db01::2 db01::1 veth0 ${bit2type[$i]} 123
+           $ioam_node_beta db01::1 ${bit2type[$i]} 123 $1
     fi
   done
 
@@ -574,7 +572,7 @@ out_full_supp_trace()
          trace prealloc type 0xfff002 ns 123 size 100 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xfff002 123
+         db01::1 0xfff002 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -604,7 +602,7 @@ in_undef_ns()
          trace prealloc type 0x800000 ns 0 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0x800000 0
+         db01::1 0x800000 0 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -624,7 +622,7 @@ in_no_room()
          trace prealloc type 0xc00000 ns 123 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xc00000 123
+         db01::1 0xc00000 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -651,7 +649,7 @@ in_bits()
            dev veth0
 
     run_test "in_bit$i" "${desc/<n>/$i} ($1 mode)" $ioam_node_alpha \
-           $ioam_node_beta db01::2 db01::1 veth0 ${bit2type[$i]} 123
+           $ioam_node_beta db01::1 ${bit2type[$i]} 123 $1
   done
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
@@ -679,7 +677,7 @@ in_oflag()
          trace prealloc type 0xc00000 ns 123 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xc00000 123
+         db01::1 0xc00000 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 
@@ -703,7 +701,7 @@ in_full_supp_trace()
          trace prealloc type 0xfff002 ns 123 size 80 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xfff002 123
+         db01::1 0xfff002 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -731,7 +729,7 @@ fwd_full_supp_trace()
          trace prealloc type 0xfff002 ns 123 size 244 via db01::1 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_gamma \
-         db01::2 db02::2 veth0 0xfff002 123
+         db02::2 0xfff002 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_gamma link set ip6tnl0 down
 }
diff --git a/tools/testing/selftests/net/ioam6_parser.c b/tools/testing/selftests/net/ioam6_parser.c
index d9d1d4190126..14b354e14d25 100644
--- a/tools/testing/selftests/net/ioam6_parser.c
+++ b/tools/testing/selftests/net/ioam6_parser.c
@@ -8,7 +8,6 @@
 #include <errno.h>
 #include <limits.h>
 #include <linux/const.h>
-#include <linux/if_ether.h>
 #include <linux/ioam6.h>
 #include <linux/ipv6.h>
 #include <stdlib.h>
@@ -512,14 +511,6 @@ static int str2id(const char *tname)
 	return -1;
 }
 
-static int ipv6_addr_equal(const struct in6_addr *a1, const struct in6_addr *a2)
-{
-	return ((a1->s6_addr32[0] ^ a2->s6_addr32[0]) |
-		(a1->s6_addr32[1] ^ a2->s6_addr32[1]) |
-		(a1->s6_addr32[2] ^ a2->s6_addr32[2]) |
-		(a1->s6_addr32[3] ^ a2->s6_addr32[3])) == 0;
-}
-
 static int get_u32(__u32 *val, const char *arg, int base)
 {
 	unsigned long res;
@@ -603,70 +594,88 @@ static int (*func[__TEST_MAX])(int, struct ioam6_trace_hdr *, __u32, __u16) = {
 
 int main(int argc, char **argv)
 {
-	int fd, size, hoplen, tid, ret = 1;
-	struct in6_addr src, dst;
+	int fd, size, hoplen, tid, ret = 1, on = 1;
+	__u8 buffer[512], is_encap;
 	struct ioam6_hdr *opt;
-	struct ipv6hdr *ip6h;
-	__u8 buffer[400], *p;
-	__u16 ioam_ns;
+	struct cmsghdr *cmsg;
+	struct msghdr msg;
+	struct iovec iov;
 	__u32 tr_type;
+	__u16 ioam_ns;
+	__u8 *ptr;
 
-	if (argc != 7)
+	if (argc != 5)
 		goto out;
 
-	tid = str2id(argv[2]);
+	tid = str2id(argv[1]);
 	if (tid < 0 || !func[tid])
 		goto out;
 
-	if (inet_pton(AF_INET6, argv[3], &src) != 1 ||
-	    inet_pton(AF_INET6, argv[4], &dst) != 1)
+	if (get_u32(&tr_type, argv[2], 16) ||
+	    get_u16(&ioam_ns, argv[3], 0))
 		goto out;
 
-	if (get_u32(&tr_type, argv[5], 16) ||
-	    get_u16(&ioam_ns, argv[6], 0))
+	if (!strcmp(argv[4], "inline"))
+		is_encap = 0;
+	else if (!strcmp(argv[4], "encap"))
+		is_encap = 1;
+	else
 		goto out;
 
-	fd = socket(AF_PACKET, SOCK_DGRAM, __cpu_to_be16(ETH_P_IPV6));
-	if (!fd)
+	fd = socket(PF_INET6, SOCK_RAW,
+		    is_encap ? IPPROTO_IPV6 : IPPROTO_ICMPV6);
+	if (fd < 0)
 		goto out;
 
-	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE,
-		       argv[1], strlen(argv[1])))
-		goto close;
+	setsockopt(fd, IPPROTO_IPV6, IPV6_RECVHOPOPTS,  &on, sizeof(on));
 
+	iov.iov_len = 1;
+	iov.iov_base = malloc(CMSG_SPACE(sizeof(buffer)));
+	if (!iov.iov_base)
+		goto close;
 recv:
-	size = recv(fd, buffer, sizeof(buffer), 0);
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = buffer;
+	msg.msg_controllen = CMSG_SPACE(sizeof(buffer));
+
+	size = recvmsg(fd, &msg, 0);
 	if (size <= 0)
 		goto close;
 
-	ip6h = (struct ipv6hdr *)buffer;
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
+	     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level != IPPROTO_IPV6 ||
+		    cmsg->cmsg_type != IPV6_HOPOPTS ||
+		    cmsg->cmsg_len < sizeof(struct ipv6_hopopt_hdr))
+			continue;
 
-	if (!ipv6_addr_equal(&ip6h->saddr, &src) ||
-	    !ipv6_addr_equal(&ip6h->daddr, &dst))
-		goto recv;
+		ptr = (__u8 *)CMSG_DATA(cmsg);
 
-	if (ip6h->nexthdr != IPPROTO_HOPOPTS)
-		goto close;
+		hoplen = (ptr[1] + 1) << 3;
+		ptr += sizeof(struct ipv6_hopopt_hdr);
 
-	p = buffer + sizeof(*ip6h);
-	hoplen = (p[1] + 1) << 3;
-	p += sizeof(struct ipv6_hopopt_hdr);
+		while (hoplen > 0) {
+			opt = (struct ioam6_hdr *)ptr;
 
-	while (hoplen > 0) {
-		opt = (struct ioam6_hdr *)p;
+			if (opt->opt_type == IPV6_TLV_IOAM &&
+			    opt->type == IOAM6_TYPE_PREALLOC) {
+				ptr += sizeof(*opt);
+				ret = func[tid](tid,
+						(struct ioam6_trace_hdr *)ptr,
+						tr_type, ioam_ns);
+				goto close;
+			}
 
-		if (opt->opt_type == IPV6_TLV_IOAM &&
-		    opt->type == IOAM6_TYPE_PREALLOC) {
-			p += sizeof(*opt);
-			ret = func[tid](tid, (struct ioam6_trace_hdr *)p,
-					   tr_type, ioam_ns);
-			break;
+			ptr += opt->opt_len + 2;
+			hoplen -= opt->opt_len + 2;
 		}
-
-		p += opt->opt_len + 2;
-		hoplen -= opt->opt_len + 2;
 	}
+
+	goto recv;
 close:
+	free(iov.iov_base);
 	close(fd);
 out:
 	return ret;
-- 
2.34.1


