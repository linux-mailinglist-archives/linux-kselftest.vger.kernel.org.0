Return-Path: <linux-kselftest+bounces-39765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F3B324EC
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4774D1BA79D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC023505F;
	Fri, 22 Aug 2025 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgrXWoTP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF6139D;
	Fri, 22 Aug 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901047; cv=none; b=XsCCRTWDfPOg5p/Gv0WDBE9XkptKgpw7kZucVTckDo0+gtzcp8P0DGRkOVh5wvkRtUr3KaEtloYKODqMdyDc3q0bl0hHgBVUfFj8OZ+ebhV8/d/lshHhWKSbDKhmpTlL+vzbkiKbzlaATVOKX4ArczzrYCrKpwibgivy8Rtw7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901047; c=relaxed/simple;
	bh=Z41eT4Sm3rWJDYGQaPehICQydnzprRlVY2vIslusYbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9C3mSoO01ZDcCFfm7V6LiKqtWTTup00R4qFjCtNWWJ/kcrpUUma66WD9n4ExaTGVyr6wPvhP0sqpYbRtnWwXyrHJ26yxThyzwWuKNu9Tj8/kpHBdtdRl0fE9z6Y6cMYB/24fW9V0ABXLdVYUo38NV+h8KqL+sz1mApQfS8DV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgrXWoTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1FAC4CEED;
	Fri, 22 Aug 2025 22:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755901047;
	bh=Z41eT4Sm3rWJDYGQaPehICQydnzprRlVY2vIslusYbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EgrXWoTPtpOdbhXf9Esi8S7HZUISlcPh2c69wj/F6SsekIY+yyIgsqoy9tt8P10AS
	 TYpDFz9SuYI98vnZ7JmWhQpUFy2jNvYkkZIURIT+QcPAZsNkOIlr1isNfCCicxcLZl
	 6T5oEMR/Esc6H+JyxP16DU/Wn7BREHvsN0F9EOGpQwlhxtbSDthZAFDShIFjwJHFBh
	 X/fC9JfYXSWOxXYtUcsS6mByN2IIjRB0FMkySQh80WKVDfr5V3nWHkWnWoDaQDpKQJ
	 9x2OwDLTBfNJGVtL3VElNRhPhZ71nev8XFaAgJSTYKEWCC3eVEZ5GrU9Bc2tznKKeO
	 tGg/xO3HMcbwg==
Date: Fri, 22 Aug 2025 15:17:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: hds: restore hds settings
Message-ID: <20250822151726.34c7c2cb@kernel.org>
In-Reply-To: <20250822195735.1673744-1-kuba@kernel.org>
References: <20250822195735.1673744-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 12:57:35 -0700 Jakub Kicinski wrote:
> +def _defer_reset_hds(cfg, netnl) -> dict | None:

Ugh, looks like the Python in NIPA is too old for this.
I'll remove the type hint in v2.
-- 
pw-bot: cr

