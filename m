Return-Path: <linux-kselftest+bounces-37582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C62B0A86D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589415A308F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07E02E6D04;
	Fri, 18 Jul 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4ORMrF1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EC2E62C0;
	Fri, 18 Jul 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856213; cv=none; b=jpv2AILrBeAETGEoRFcXNaWv+gyrSG9Wtb7y1ZaEy3FlwQAX2r69eMCaKHctGYMwr9GBbyLm67Q01GQEp/zoC22ssaQg55MogkrJ+1t3xtx3gB+B4pyIAMR1ATDlgf4LYtccd6Zi52gY5d8KlX1y2Bp5O682q04uUGd6CzQ1748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856213; c=relaxed/simple;
	bh=YGC91E1l1DSQcb9kcxNTx91MB8JFQkKUz2qanJ8u79c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLhKPbMxpVXdQvASsiXZCoDT3poLIqnr3if1qsx6tGREfinKAZwS3aPb3zyXRfzDCoAb5XGw0vMnyXvKC0qaD2L3WUjRPBoepBR0qDAbuJIKlzChrqezk02+nMLLhSbiZajyaDkjigbbye8HLBJcIk7qixW5oVu/fPVYQweTSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4ORMrF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA69FC4CEEB;
	Fri, 18 Jul 2025 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856212;
	bh=YGC91E1l1DSQcb9kcxNTx91MB8JFQkKUz2qanJ8u79c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d4ORMrF1dm2Kj9GfCsCY4Pjw+XXRYh03Lk4T9A9sF+jOcad3bi7kDxJVxnDWGECAZ
	 rcmk/hYLqR3sSyypnqME8m7/2BO6cjoUfvQ9NEUnpBoNM9/3sbfc8FUoinzhg6IgAe
	 SMJp3oEThQbGklSWPdygYV6bNDoOzBYNo+58xfdQh6nUp1QEnI94rntxbLdgFmTORP
	 Q2JR3WjeGDpWgxEqHuStqa//25zdaOfr09bsQr+s16sfAGThEzE9JAjwfSxQOzd+Xu
	 jYheXvVnpNDfcJ4mheNbBK8f2HobUpNiXKSenkp4iLRQQvGEUKHA201W630Lg6vtNG
	 +NO7gSz3wMCBw==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	enze.li@gmx.com
Subject: Re: [PATCH v2] selftests/damon: introduce _common.sh to host shared function
Date: Fri, 18 Jul 2025 09:30:10 -0700
Message-Id: <20250718163010.59681-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250718064217.299300-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 14:42:17 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The current test scripts contain duplicated root permission checks
> in multiple locations.  This patch consolidates these checks into
> _common.sh to eliminate code redundancy.

Selftests are very important parts of DAMON project.  Thank you for making it
better, Enze!

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

