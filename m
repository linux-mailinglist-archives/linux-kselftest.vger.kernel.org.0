Return-Path: <linux-kselftest+bounces-18914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E998E0F9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70153B27A31
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524481D0E26;
	Wed,  2 Oct 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="W1uRpdw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A31D0F59;
	Wed,  2 Oct 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886934; cv=none; b=mlY47hyDWuuuFvntlf3O3i5TBLGomn+l33AYKYxhC8FmIzywy2WSkZO2ElznLXoU0qoRziXtVWgASQV6elOrpp2n307PFSug7YOwmefqvWJKdCxBKEmF/KYw82W8dsvDnItLvpGZQRBfzfHYemmQNBUvR94hYm3Jh0roaQWN1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886934; c=relaxed/simple;
	bh=HKYLYRCqqjk6JgiEePXpC8AOhh1D4taF1WtnlYuBiUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sLsdJaXiPleOkxgz3H1FxtV4XF+xQT7BJ/rnxwtrJlGfh6E7IOpI/0F3vvIKdGvWHfj+JLAvc1c+dfIoMO5CubOa87I8spE3jtsovviNRn+y5jrbOOOooyxDVbndpQvOSJ6inHEMJatO6+AguAdIZkjy3yvsabW0LftOZxNB8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=W1uRpdw/; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id DE3F2200C975;
	Wed,  2 Oct 2024 18:27:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be DE3F2200C975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1727886472;
	bh=H2H46qCWXcIO0X1QQ00R+gMM1zIRewdimegBl5uBl34=;
	h=From:To:Cc:Subject:Date:From;
	b=W1uRpdw/IJEcH0NrmXfL+gdJj/SNLmGWbcuNISX7TtCviZrikNoNAqKkMC7yiHGw+
	 E3Ng+6pok5F4NBFdNQ+TCjuWbZu2vqsI1jZlZL1CjU+4LlgmqGxqYixZ4XMaaFCn6S
	 6ixDhlNdfy0pdiP36Oq+VM0GYEtkI8m0bl+KrSEkMlab7k2ej2dEH7HoND0BwvE7yJ
	 iG9Wfd7apBBQpJCnFI5KxNZoCPu9+bRnO3dx0aR2XN4roUvbKTvL/5j9nU7X4cikwk
	 2jwbKu8xdnafw3+lyFbjnbv78UPMac0YP2tD8NgT61cCaQlysaYBpAtL6YVIYxZKDu
	 AabPe7NnSOFVg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 0/2] selftests: net: ioam: add tunsrc support
Date: Wed,  2 Oct 2024 18:27:29 +0200
Message-Id: <20241002162731.19847-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - v1 missed the merge window, so while we're at it...
 - split changes into two patches instead of one for readability (#1
   removes the ioam selftests, #2 adds the updated ioam selftests)

TL;DR This patch comes from a discussion we had with Jakub and Paolo on
aligning the ioam selftests with its new "tunsrc" feature.

This patch updates the IOAM selftests to support the new "tunsrc"
feature of IOAM. As a consequence, some changes were required. For
example, the IPv6 header must be accessed to check some fields (i.e.,
the source address for the "tunsrc" feature), which is not possible
AFAIK with IPv6 raw sockets. The latter is currently used with
IPV6_RECVHOPOPTS and was introduced by commit 187bbb6968af ("selftests:
ioam: refactoring to align with the fix") to fix an issue. But, we
really need packet sockets actually... which is one of the changes in
this patch (see the description of the topology at the top of ioam6.sh
for explanations). Another change is that all IPv6 addresses used in the
topology are now based on the documentation prefix (2001:db8::/32).
Also, the tests have been improved and there are now many more of them.
Overall, the script is more robust.

Justin Iurman (2):
  selftests: net: remove ioam tests
  selftests: net: add new ioam tests

 tools/testing/selftests/net/ioam6.sh       | 1832 +++++++++++++++-----
 tools/testing/selftests/net/ioam6_parser.c | 1087 ++++++++----
 2 files changed, 2129 insertions(+), 790 deletions(-)

-- 
2.34.1


