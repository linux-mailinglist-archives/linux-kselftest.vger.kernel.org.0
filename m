Return-Path: <linux-kselftest+bounces-21777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB409C3E41
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 13:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD2D1C21B0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB751991BE;
	Mon, 11 Nov 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYfOTNNd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57814B946;
	Mon, 11 Nov 2024 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327317; cv=none; b=Jc0JVUKJ/g5mgcREpyJ20stezYxFi4nsrC1JaSg8foIIIc1hyfuXIXqZzuYwIaiabNOalAIpqqjCulnD2qtZZ7J7C1dd16DPi9pnl4IgMwWK8vmKc2zFJJlhHXlozWY8Ix3l84Yyk7z65IjN2hdllBFsIizuhSHckG9abRUtKIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327317; c=relaxed/simple;
	bh=PDJaJMj3vIEuqEBwEC4j33YkGMEUjJ+7c3OjOHvEO4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMTz5adR6AX8GVl9swZWse5+Pj41r+ahlX0iChm1byJOxkOYU7+GilBZuAn9JyXbMSnRdCFngkzGJPjgSgoD3O43uif1lk1/M8h8GpAoxaZNAtTQMnzptR543AbUEVq72LuE16FwhkEn9kv9LQjMnANYO+Vdb2ddCzz+0peTIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYfOTNNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C59C4CEDA;
	Mon, 11 Nov 2024 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327316;
	bh=PDJaJMj3vIEuqEBwEC4j33YkGMEUjJ+7c3OjOHvEO4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYfOTNNdRuLeihJPJoxrshFVR6+9GzOiBgncADPUsWLj3HvbnhajESYqyJsinLgK6
	 nRVRD/abTeyjIUwLsx4RI7KATs95vjn999JRaSlRqb/WDkjMi8FLtQJvsjS72F9oXt
	 eaxwRVv0tXxVwK5EFwgJKri+U2HdCXSJZwwAyn9tS2LvMH7rfxuXJAR0JRTdaK+68+
	 KUFT1fU0yYKXJAbevnwWkhTyxBgaxAVZUejEjZI1U4NEqkj55rrbE0ZvC+bCMG3wMS
	 FLQgYQXCpDz0qpRPdWS/Lfvhbx4jZry+HaSpGimz6go0jvuZM8WJ4s6wq1amtK91SN
	 rjyia24AcHt7g==
Date: Mon, 11 Nov 2024 12:15:12 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] netdevsim: add more hw_features
Message-ID: <20241111121512.GU4507@kernel.org>
References: <cover.1730929545.git.sd@queasysnail.net>
 <b918dc4dd76410a57f7516a855f66b0a2bd58326.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b918dc4dd76410a57f7516a855f66b0a2bd58326.1730929545.git.sd@queasysnail.net>

On Thu, Nov 07, 2024 at 12:13:27AM +0100, Sabrina Dubroca wrote:
> netdevsim currently only set HW_TC in its hw_features, but other
> features should also be present to better reflect the behavior of real
> HW.
> 
> In my macsec offload testing, this ends up as HW_CSUM being missing
> from hw_features, so it doesn't stick in wanted_features when offload
> is turned off. Then HW_CSUM (and thus TSO, thanks to
> netdev_fix_features) is not automatically turned back on when offload
> is re-enabled.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


