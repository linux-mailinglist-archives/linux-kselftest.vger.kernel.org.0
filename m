Return-Path: <linux-kselftest+bounces-4467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F684FCD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5924B28F9D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7A284A50;
	Fri,  9 Feb 2024 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8pT93BQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABF84A3D;
	Fri,  9 Feb 2024 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506924; cv=none; b=fynP1G+gD/5sHMdqcR9ikoOmUcBLS1nYgSWU4Ugh1QRclw3S1b4PJL9Js2kBOVPJHuxlEk5RNZI/njBnEQ96QsWQ5/EKVjCH0QASt9PSUngZ+6U+f2GBID6arJ1zBhzJ0E8oGg5ByGBiq7wFnUrEC17BlnJmSprjJpXI4A0dui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506924; c=relaxed/simple;
	bh=S5bK7PpprLEmM5J7wGAC6B+tigQFvAc/2RjPAzXhZ/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVv5LW8i9ZAO4Y8PaGHHoD3OvF2Qls+Od73tUTj7d2A06THqVwnBFC+vijfvpC2/AoVeoEbTp2MiGQOTrBP/QFadg7jCZZY2XBfccD3fvyLkF35fImWabDIiJgRo40wMtrIX+N+d2xeb3s3cGxDWonfZg2qmuo+Wqi2ZnLl0Nhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8pT93BQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBEAC433C7;
	Fri,  9 Feb 2024 19:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707506924;
	bh=S5bK7PpprLEmM5J7wGAC6B+tigQFvAc/2RjPAzXhZ/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o8pT93BQGox7YHPYMKzkr8sIVwAyDJ22XmwVoQZtcoJxqOKEGRhTfraCD/EWbVBfl
	 yCkypA3nnxjdAWy1NxmEgW7IhR67q/skSRJ/Es717vWuvZnqPwGjfEhDFKj/Wh7UCa
	 7GDOsVGUfEi97gbh76Rqc9flI7uDupaa3bo2wxQmc/Iw0yOjZpXNRZAcapaECJ0AY5
	 j2EZ1/LG4rMa7aT4tXqTqGPSxgelMrtZnT2ebyeze0avlT+/lfAH1L5RSUQVoeLq6l
	 UDcpVVer24CFy2PnN43hf3v8AsTRIOsEQ4/BIQADXE3FqatVUXdah5lXJ6DazqL7Tu
	 zwpq+1cEKrkOQ==
Date: Fri, 9 Feb 2024 11:28:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <shuah@kernel.org>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing multicast
 routing config entries
Message-ID: <20240209112843.77c45dc0@kernel.org>
In-Reply-To: <20240208165538.1303021-1-idosch@nvidia.com>
References: <20240208165538.1303021-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 18:55:38 +0200 Ido Schimmel wrote:
> Targeting at net-next because this is where 4acf4e62cd57 ("selftests:
> forwarding: Add missing config entries") was applied to, but you can
> apply to net as well.

I resorted a little bit to get closer to sort --version-sort order,
and with that we'd have a conflict :( So net-next it is, thanks!

