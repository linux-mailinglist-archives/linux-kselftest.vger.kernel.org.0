Return-Path: <linux-kselftest+bounces-17293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0BA96E08C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0414A1F26566
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAA51A2C2C;
	Thu,  5 Sep 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f61+UMjt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BFA1A2C26;
	Thu,  5 Sep 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555411; cv=none; b=p/LIeU62QOLUl+eF5n6lSfpUVoClLgnAPa2C0HtAdNQU9R/RXWO29cVrFfYJREhulm/GwB9nVbpO9kQfJuqrAvp4hcH2T/kFP9Z4Z+BokyV+w9dQmazI55Zu7B5xSnHnMyAwidUhKa6aTZopVFTwvlzD94xCTK56HtRcPXNXBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555411; c=relaxed/simple;
	bh=XZY+ZIl3xTZLq0pUUjZV8QwdjmbY/dX6TNFjStLoIuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuDqZHL7QhYG6vpklyrgXyCBnKbrb2hAsoL1h6UMpZh/jKMAZKwZvGcxzXMOp5DyVOWa5ZXg+qNLQ6y8CEMg2TGzPOSv8vpWxoHJKFZ1FVITddqkqD0dXFUnfNyRnBt0N4S+wxaXEaOwsqPBU7YHG+fsJ03baUMbeRKsCU8477c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f61+UMjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB20C4CEC3;
	Thu,  5 Sep 2024 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725555411;
	bh=XZY+ZIl3xTZLq0pUUjZV8QwdjmbY/dX6TNFjStLoIuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f61+UMjtIhUp8Zsk0fZNF/XRhl2HEZza5h3t1cwFO551RBRWG+F8dJBl6T0NhUpIL
	 btZo78sehfSCFXowsJ+aRPDHP663f7/NsLEVbVTB0ylxEs5cspFGx2zKX46fd0+aCE
	 5pE9JURnXgRpa64G9DX9FR1JdQOy0Ws2zm5qmi27kCY1fi5ncH1Q6f/yssSDsvwe9z
	 xN5DM2S6coi9s6pBV7sFkVWDh3NlqSJEs/Y4/VI+9/Wr7t53vm/MHTHbOUL/yl7jWy
	 GWzC5WE5SOZsG10NQVYybJhd5ah1jF2IH26oUp+sQDynVMsLB+ncRoKht+pByWwCQb
	 IcgTjlUr3Qmuw==
Date: Thu, 5 Sep 2024 09:56:50 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: Fix missing kerneldoc comment
Message-ID: <202409050956.05AAFDD0F0@keescook>
References: <20240905024757.3600609-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905024757.3600609-1-davidgow@google.com>

On Thu, Sep 05, 2024 at 10:47:55AM +0800, David Gow wrote:
> Add a missing kerneldoc comment for the 'test' test context parameter,
> fixing the following warning:
> 
> include/kunit/test.h:492: warning: Function parameter or struct member 'test' not described in 'kunit_kfree_const'
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20240827160631.67e121ed@canb.auug.org.au/
> Fixes: f2c6dbd22017 ("kunit: Device wrappers should also manage driver name")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

