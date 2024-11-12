Return-Path: <linux-kselftest+bounces-21878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1D9C5D08
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A3FB31F04
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4B205AAF;
	Tue, 12 Nov 2024 16:07:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBF205AA3;
	Tue, 12 Nov 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427663; cv=none; b=qNlpwj/LUpomn6kf4/WdQBE6UF9P25v/C6gM5URCQzJ3zbvc/Mfcso5MNzpGIa/23DOoPkepDrOn25xtN6ZcDk3PJHhssgO6xnLgUzWZohLAmR8T/QODZY9NQYdoEh3cwQbbMWO4PXTw3QLVyY97rh37ZbU5lW/3c0iQ4HePHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427663; c=relaxed/simple;
	bh=iQ+pQZQ1lP4DRk37l4AFfaefECvHNbZvcD0IBfbSbuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kxn8PQAiETZXMIjvt38c+XetzLCenDnUMd2ol+dtDrsasX8mcrKC4vFfeNuxqSGdYnXOV5KsCis1fQ9hW8QunIkte5/SuxAPj4IGNWbr5uz6/DI8SdVgOHR43n3R5Bz2HjcMNX002NWOIKu4gN+bUaMOgePIFSHxhWioiC/ftII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815A0C4CECD;
	Tue, 12 Nov 2024 16:07:41 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest/arm64: Avoid detecting spurious PAC key collisions
Date: Tue, 12 Nov 2024 16:07:30 +0000
Message-Id: <173142698242.893467.5937732812824342152.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241111-arm64-pac-test-collisions-v1-0-171875f37e44@kernel.org>
References: <20241111-arm64-pac-test-collisions-v1-0-171875f37e44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 11 Nov 2024 16:18:54 +0000, Mark Brown wrote:
> The PAC tests currently generate a very small number of false failures
> since the limited size of PAC keys, especially with fewer bits allocated
> for PAC due to larger VA, means collisions in generated PACs are
> possible even if the PAC keys are different.  The test tries to work around
> this by testing repeatedly but doesn't iterate often enough to be
> reliable.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/2] kselftest/arm64: Don't leak pipe fds in pac.exec_sign_all()
      https://git.kernel.org/arm64/c/27141b690547
[2/2] kselftest/arm64: Try harder to generate different keys during PAC tests
      https://git.kernel.org/arm64/c/91a6533811bb

-- 
Catalin


