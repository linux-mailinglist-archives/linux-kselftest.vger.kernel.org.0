Return-Path: <linux-kselftest+bounces-20204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2D9A503F
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78F01F22721
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D718CBFE;
	Sat, 19 Oct 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL1/g2JU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF479D2;
	Sat, 19 Oct 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729361848; cv=none; b=Ja10Qp/Kf79dJVOZOU4X2tacIBvO0So+TKkz6KMZRItTVRyGOcXBE/NqaWGXUR81Kr7Ej120gA02u+pt8qVXxvQLyCE8AXoOux1VP3RUOi7obc3Cz+949cTcnb4fs309rf5QiziU1OqyYt/hdsRNPURHWbBZTBIdZ1mW9R9sM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729361848; c=relaxed/simple;
	bh=OjfRNG+8+VXyvc/ydeEaopvwIQezxqX7F7mkQOYQPa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsvLS6EvIT2Rl3SsLdQps2dlrSmVpEfHnRlF3EG0VJjIgB6bysehNzqnhcG72q1539827zTkATOpcbX9kpKw7jlI1YLOrO9D0SYZSSXMG5WFeju37OamA/Sf4oD0V3wWTtwFMlUKNkAR2FLtTwwbrRj9+JZ5pGSqCf67lkzDqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL1/g2JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F01C4CEC5;
	Sat, 19 Oct 2024 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729361847;
	bh=OjfRNG+8+VXyvc/ydeEaopvwIQezxqX7F7mkQOYQPa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KL1/g2JU6oOG/pSe8bdjey/XWgdJf6llUp3HVG0C/QbMTZ3p3gNDb2u6+oipbtOQF
	 6XxUzQRe2u/OHmNAylz7Zk7RAUXNjQQuLzSl8llJroTUvXCyFxKuS7b8hrdLX4dnfU
	 6IrNnt3grvQrREPFUE63HASAVc6a8a7BoI3Tk9vLtLzt/MHm+8pIxgPS5/FY/4iC4h
	 lJ2DeOgkXjKS93fTrxEYOAO4Y1J7H70xLt27X51E2az8JUppYBm2uQy3v/sH1ErNHX
	 8N0jTPj3VVAAPH19fkqaOu9cI5WWjDFS02az2dutth/jWNwjx11qAfniFrNc4f3kqY
	 62AlMCxUN5suw==
Date: Sat, 19 Oct 2024 19:17:23 +0100
From: Simon Horman <horms@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup <anupnewsmail@gmail.com>
Subject: Re: [PATCH] selftests: tc-testing: Fixed typo error
Message-ID: <20241019181723.GV1697@kernel.org>
References: <20241019-multiple_spell_error-v1-1-facff43b5610@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019-multiple_spell_error-v1-1-facff43b5610@gmail.com>

On Sat, Oct 19, 2024 at 11:52:21AM +0000, Karan Sanghavi wrote:
> Corrected the multiple and different typo errors in json files
> 
> - "diffferent" is corrected to "different".
> - "muliple" and "miltiple" is corrected to "multiple".
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Thanks,

This addresses all the spelling errors in these files that
I see flagged by codespell.

Reviewed-by: Simon Horman <horms@kernel.org>

