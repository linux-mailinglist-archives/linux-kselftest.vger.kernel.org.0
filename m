Return-Path: <linux-kselftest+bounces-5240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6373185E9AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 22:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763661C211AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5761272CC;
	Wed, 21 Feb 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpLIp74G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A91272B2;
	Wed, 21 Feb 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549926; cv=none; b=s7/8Fz2jkxTI1IBFmg5gejv/kuT7hvvRR5DzrLFPJclzyaeiVH+mFggRTsh1VDO0KT9/jWDnJcDFcDwlOPO5TpR/esrgfz8BzS+dr21jWvrLNy6old0y7DjfgUuwpjKXbo6jAlEZu85jxkU3rTHpIxlWkiKW0aRGEAfFa0fkHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549926; c=relaxed/simple;
	bh=8J2qCT0DoA+RjwZLq8bVL9j6Om6Ciwb1ENnf1yQpYlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=guwIrw/+F3VgLol6HphyV4gWHRz+18T1kcBLcz/9jpX8qdYj6+UbM0ooSoBiksi+hIHXQIzYCLehlpAsdu+Rm3TAAaoBvAiL5xrTdbJYAY5SoS4BhUg4aP7l+rmGXRafcjyF4/NDV4Zn14njEWWYdu21kY225Q3NpgNnZ7DIqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpLIp74G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E66C43390;
	Wed, 21 Feb 2024 21:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708549926;
	bh=8J2qCT0DoA+RjwZLq8bVL9j6Om6Ciwb1ENnf1yQpYlw=;
	h=From:To:Cc:Subject:Date:From;
	b=VpLIp74GuJHeOB20EiEU9E4Uj69pUQV0wCZFafy5grnsFdk7ndxz2ojonPf67VK5B
	 F/S5+xiy27KLVygd2k41bGGUUuVpAXuT8DvWIWCxENPF+Rn7wX0Kd58TqkyOBTT6F7
	 k6U8L+4p73G3umtGvqpVl1ECGWNmXuZ3kvW0brYzlc6CVHKWj6QIjAKpUfdfBLthAK
	 yTswzNVJ7rDeFJZJgSoN3gks3znC+5sQTC7Dl55mCQqvbTvm2AO6XhssHCeFZzgMCW
	 8MhR+mXpDoi4ungY1orAouKnsfazA2ix06FuIFkGP6XkoPwoX04gto+GwoF94twgb6
	 rvgrS8QyMm3Ww==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: vincenzo.mezzela@gmail.com,
	javier.carrasco.cruz@gmail.com,
	bernd.edlinger@hotmail.de,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/2] selftests/damon: misc fixes
Date: Wed, 21 Feb 2024 13:11:46 -0800
Message-Id: <20240221211148.46522-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending misc fixes for DAMON selftets on behalf of the original
authors for more visibility and inclusion on mm tree.

The patches are same to their original versions, except added Links: for
the original posts, and Signed-off-by: of mine.

Javier Carrasco (1):
  selftests: damon: add access_memory to .gitignore

Vincenzo Mezzela (1):
  selftest: damon: fix minor typos in test logs

 tools/testing/selftests/damon/.gitignore                        | 1 +
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py  | 2 +-
 .../damon/sysfs_update_schemes_tried_regions_wss_estimation.py  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.39.2


