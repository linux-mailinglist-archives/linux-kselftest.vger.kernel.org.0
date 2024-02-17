Return-Path: <linux-kselftest+bounces-4894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31ED858BEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF37F28AB18
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347427EF;
	Sat, 17 Feb 2024 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8B6/1Jl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB74C66;
	Sat, 17 Feb 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129986; cv=none; b=WP5EunA6Em5tCmHcTWiZt2M+NIEzJ12KvzAh+RODAzbQR/2cfih1QDpo5mrOIlXAdYgQJY7k3CEa/zYTc5gMFjbKqj6jHNoBTq1oNkMbbRiQHfDmD5Dd4xyK0PCSSp8izFUf2WL/ZLZGFQaW554n5j1KTTqYaJ68RXEW/Z8/FZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129986; c=relaxed/simple;
	bh=RUTsPCs5CDBmzfdA4VFoZw67WazoFZLP/DYOY57Ut+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6G9Q+/68+SZUordQtvyGjLod1p347ezdVAUcHFhZsuRk2q6wLYK6zAakPAPLUs1tr+Z/NP7dUWxMQTjorAwQLrQMg8/wB4q1dtdE6rVcUCe162LgPdYitA4GwoG9m2h1NVniLJVyQ2oJH894qbFznbqcxtGeEUdrjy7akmwC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8B6/1Jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46750C433C7;
	Sat, 17 Feb 2024 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129985;
	bh=RUTsPCs5CDBmzfdA4VFoZw67WazoFZLP/DYOY57Ut+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R8B6/1Jl5cKAYlj0c/e5PbV46VavkZ54dWFB4/saJux5mtots85dpS51s2+jxMrlO
	 HHxxQqx3KfK7blWBJlpNVKONSfi9hjCMh/Kw7rP8PrmkXkOq/gkeDkLFAHmHZKw2hn
	 rnOFrzHmj0iufwDoBACao3nKcbc8yMuhh+H2RU2Ola/rfPurZoGh11qMDmcIZwK0t5
	 /6ETVbXsZpHFT5n2KGrdiBX58K4JOsmc+/4JIdOF+9n72L0hD8MdwZYWDcmnWVn1Vp
	 dIQBrEGCtpBdp2o1WT5vdmht2tBH4Bbbb5gBx+5mYLPxk+AB4cJcAQN1TZb/tPHL1s
	 JltOPccSKjHFA==
Date: Fri, 16 Feb 2024 16:33:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: jakub@cloudflare.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [RFC 0/7] selftests: kselftest_harness: use common result
 printing helper
Message-ID: <20240216163304.2ab0ff7a@kernel.org>
In-Reply-To: <20240216163119.7cc38231@kernel.org>
References: <20240216004122.2004689-1-kuba@kernel.org>
	<202402161328.02EE71595A@keescook>
	<20240216163119.7cc38231@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 16:31:19 -0800 Jakub Kicinski wrote:
> Let's see if I can code this up in 30 min. While I do that can you 
> ELI5 what XPASS is for?! We'll never going to use it, right?

Oh, it's UNexpected pass. Okay. So if we have a case on a list of
expected failures and it passes we should throw xpass.

