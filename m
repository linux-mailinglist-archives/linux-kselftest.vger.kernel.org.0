Return-Path: <linux-kselftest+bounces-32179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29325AA71D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AB09C22DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A94255246;
	Fri,  2 May 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/GqyulW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F1255232;
	Fri,  2 May 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188986; cv=none; b=LqP/d5ZyRyspW7ZGQ7oriZTpRlCoVK5t4TS26wO4c7hBLACyOMclMF7G3GNE1RqQ/jGtWweYRnjSy5Ouro3mzzrPqpsmD/H6yQYlzgE9v4AE2BpWDwo1+4yyuOQ8FvyfmWVX46r4pljefq0mTFk6DJbpl4dtRcCOI0/BTkQQQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188986; c=relaxed/simple;
	bh=Ib1TqcrHx6htyMHOJudLtaj/PP66OW6d82PiRhdb0l4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GIR35j8gmlqF2gbXqd+ixRQzrLNj+4mBgoH2CXKfwQnm8sjcYz/RFO7A5FKM236Ois2cQulKhx2zlQPXdKiF2SBR5KvjoYyFQ7vkVUCUDBnZvUnuAdFcT0mhZNE5rYXsc5GMzuwAbTKorXKem8Z0ZTuQMxiWDTNeoPH7gdGpkko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/GqyulW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F6BC4CEF3;
	Fri,  2 May 2025 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746188984;
	bh=Ib1TqcrHx6htyMHOJudLtaj/PP66OW6d82PiRhdb0l4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V/GqyulW1RSCehdxqbo+J52NDT7Q2egM2+OLpvsDHlN6YOHskeO+eZ1JOPwLkCZ0P
	 vP/NNMFTENEUHEv2fceinIUUCP8nMMaPit/nsXPRBcW3GfIW+mSE6e4F0srVkaybFn
	 QG3FLDVhblZoUojVT2KT6PIj0OKAqfZhm6Ked25m7zX6Qws7KwM9fcgpLMiWqvJsmh
	 svqoKIN5j117XdIlGvK9kIfkhgW0/lGZs0PBbgDDEGYAyBPACvvyU8zQJbQoP+/HA4
	 I/ngJqfR2Oa9qKSBa/LheXZvxCNEiYEEeIMYoltps6WjyZRcmwt2sKHVnXHPerSYMb
	 JILPLok3yYSKQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 May 2025 14:29:23 +0200
Subject: [PATCH net-next 3/7] selftests: mptcp: add struct params in
 mptcp_diag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-net-next-mptcp-sft-inc-cover-v1-3-68eec95898fb@kernel.org>
References: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
In-Reply-To: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JV5KRwJz/0wGNszA8+h6v2IEAspsGHzn0JdEiVMYgzU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJEdq1Ii+rZVH7X9OdyzgVPW2ZMT9NufPjeW+iB4poNj
 YWPzT6u6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIXTUjw6pmHr39s9ovT730
 voy5Rrjumnp3lkXWWyae1Y/DC55GvGL4yXjY4e7/q85LQ9/tOKnFnphve9X3HseOmHO/6g1PWqQ
 dYQYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

This patch adds a struct named 'params' to save 'target_token' and other
future parameters. This structure facilitates future function expansions.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 37d5015ad08c44485f1964593ecb1a7b25d95934..ea7cb1128044ab7f9bad50cb29856c2e290f385f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -19,6 +19,10 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+struct params {
+	__u32 target_token;
+};
+
 struct mptcp_info {
 	__u8	mptcpi_subflows;
 	__u8	mptcpi_add_addr_signal;
@@ -237,7 +241,7 @@ static void get_mptcpinfo(__u32 token)
 	close(fd);
 }
 
-static void parse_opts(int argc, char **argv, __u32 *target_token)
+static void parse_opts(int argc, char **argv, struct params *p)
 {
 	int c;
 
@@ -250,7 +254,7 @@ static void parse_opts(int argc, char **argv, __u32 *target_token)
 			die_usage(0);
 			break;
 		case 't':
-			sscanf(optarg, "%x", target_token);
+			sscanf(optarg, "%x", &p->target_token);
 			break;
 		default:
 			die_usage(1);
@@ -261,10 +265,12 @@ static void parse_opts(int argc, char **argv, __u32 *target_token)
 
 int main(int argc, char *argv[])
 {
-	__u32 target_token;
+	struct params p = { 0 };
 
-	parse_opts(argc, argv, &target_token);
-	get_mptcpinfo(target_token);
+	parse_opts(argc, argv, &p);
+
+	if (p.target_token)
+		get_mptcpinfo(p.target_token);
 
 	return 0;
 }

-- 
2.48.1


