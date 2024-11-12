Return-Path: <linux-kselftest+bounces-21883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91ED9C5CE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F265283232
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5E72076BB;
	Tue, 12 Nov 2024 16:07:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346220403D;
	Tue, 12 Nov 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427677; cv=none; b=TkcgUaP4qfMzrwvlNSxnrkf2yb/o/iZSh1hjshzn4HJF1Q7Ak8dq2ByEG10dc64OX0UiLeVBSy7VB1SV4oN/VOetMQUGVI8aXdiPXtB35IqAbjI0K87YFQISCcVrREg6fxb6eEM29IrtikbWWca1JYo8RBOue5p8jEPcLnWVbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427677; c=relaxed/simple;
	bh=Q1lWic/3x2gOUIzAVLxwWeQONSIyBWFMv5MTMPK91/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1u4WBz5yjYA6LXJwENSaGiOkAz1Ct0/cm1us5M4GQbCPB03rQoEpOnf2txg2i4PxJk+Y8XeK7gqol5KLXVoKPu4WzT13rcOgjMhsIFXopcIxBFgdXjQF0WGOInYFLu2HvTvkxRakkQIzfsLvAuKzZD5QpNeVYTZ4B3wYj9o/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE60C4CECD;
	Tue, 12 Nov 2024 16:07:55 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: (subset) [PATCH v2 0/6] kselftest/arm64: Test floating point signal context restore in fp-stress
Date: Tue, 12 Nov 2024 16:07:35 +0000
Message-Id: <173142698242.893467.13323137433955232156.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
References: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 07 Nov 2024 01:39:19 +0000, Mark Brown wrote:
> Currently we test signal delivery to the programs run by fp-stress but
> our signal handlers simply count the number of signals seen and don't do
> anything with the floating point state.  The original fpsimd-test and
> sve-test programs had signal handlers called irritators which modify the
> live register state, verifying that we restore the signal context on
> return, but a combination of misleading comments and code resulted in
> them never being used and the equivalent handlers in the other tests
> being stubbed or omitted.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[3/6] kselftest/arm64: Corrupt P0 in the irritator when testing SSVE
      https://git.kernel.org/arm64/c/3e360ef0c0a1

-- 
Catalin


