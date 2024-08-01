Return-Path: <linux-kselftest+bounces-14595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28A943E47
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 03:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10631F226E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 01:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FBF14A4C0;
	Thu,  1 Aug 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVtBm2O7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E785132116;
	Thu,  1 Aug 2024 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472367; cv=none; b=odi7oeBLhEOXIHizv10uCt/rnJf107pDHlVDpvSschE0QVEV1dUBrph9KDzedlip1zAcxBfSrL4T3PQwE19goFo6n/60AxumuAmw2N/EvuzohLBKsQo/Vysfz6MIsTTerBt8gA63NFaEt11EjH7jMMbx33+ILj2GeeKvCa2+0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472367; c=relaxed/simple;
	bh=i4E4vUbJdf2hJ7IZEv4pboAln3L4qmN9XL36u9p/qqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRoL3RO4qg6WGcaAzlp0+1dhz/dcwGTR1mSZDNEiYlFlke97UxSYspl5P23Wy9SHQuVd2hTwJxKdPOVevZp30ANlZ+zGVcw0jGss578mTPMaEfwsO1z8aHNoSC2mOdRnMU3DjS7SQ+5uECjlhUzgskUqI4we/xjbE3vZy0dzBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVtBm2O7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794B2C116B1;
	Thu,  1 Aug 2024 00:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472366;
	bh=i4E4vUbJdf2hJ7IZEv4pboAln3L4qmN9XL36u9p/qqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UVtBm2O7jnIn06XbAIbUQnFDBseutZna17W46JKTXvqIyl6riAMnBEphZCP3WEPRW
	 4Xtvz856s0VW5LLa8QPjA20iw3i+7Klb4E5EoOB1wXuN/+VpPBq1zeLU2Av0STtIH0
	 RPLDwsYSZvEC2x2v/2X1st/GT8n37NnkF7yinXGK0NSF3IWNQLx6pOYpt7Gs+SnflQ
	 GkC41hEuI8hQnCv7O+RIkmb57ylU6KNxW01+oYS0QiwZfN/wBEIQMDFYxvIy0GTt1l
	 87vWn4EVzXWIvhvz5sbHap8sSHmaw611qohx6WO79Tm5XnkooF5r7eO4Bm+FbDKbCE
	 R8d60HvzAqryA==
Date: Wed, 31 Jul 2024 17:32:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, Shuah
 Khan <shuah@kernel.org>, "Joe Damato" <jdamato@fastly.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] selftests: net-drv: exercise queue
 stats when the device is down
Message-ID: <20240731173245.2968988d@kernel.org>
In-Reply-To: <87cymt7pmu.fsf@nvidia.com>
References: <20240730223932.3432862-1-sdf@fomichev.me>
	<87cymt7pmu.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 13:34:58 +0200 Petr Machata wrote:
> > +        qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
> > +    except NlError as e:
> > +        if e.error == 95:  
> 
> Could you do this as if e.error == errno.ENOTSUP?

just to be clear EOPNOTSUPP ..

