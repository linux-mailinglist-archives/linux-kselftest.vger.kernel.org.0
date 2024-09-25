Return-Path: <linux-kselftest+bounces-18341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D1098558C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E821C22DD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E315747D;
	Wed, 25 Sep 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S06Y286n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8936B7E574;
	Wed, 25 Sep 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253247; cv=none; b=QuOvBxKdn4iBgi1aJ1p66jYIVQx0LJeFq86lkkWk7Tb0Y8oHOXExwQvXaLpywfSNXvsfaDlcz4+Vv8Zw7k61y4zqQG3Op2rg4b138DalQdZZs69FSzRP1Nt6XlC+ioQCJkDg1Gc3jrOPXOpiyoADeTSGbXQWF3kwRDe258syIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253247; c=relaxed/simple;
	bh=UIeKUPWQ5pMzjpA1v30b0CyqBO4MAApMvfsNIZ60PFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdr7Juo2hMshsYNCFGHNj8aK3FRHTSV4sarYSxCfxJ3HRBdpfqXN1RKByISlVjic+FMZbeBhZ62yWmOLYMupNJcfwPJ2eWZFcu8IzCszmbKI5AnNEGxMxS6U3JMJnLX/59nbFi3vXp67nxjBleI9NT5uk1PbgrUDem7TxoSwmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S06Y286n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C54C4CEC3;
	Wed, 25 Sep 2024 08:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727253247;
	bh=UIeKUPWQ5pMzjpA1v30b0CyqBO4MAApMvfsNIZ60PFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S06Y286nhiqIcX73I9iY2yZikiRKtkh+DNSdhpkd5s9MOLhTz5nzJZ5fUkQ5J1Crm
	 6Oo9vNCTJligQhVgFYCmJgKlFSZaMIena48IXEbAh6W2vh8FaFR/asNzvYpF2dI0Ak
	 vI2Trj0mPCd6/U4v+HzqALROnShCsWqu438C1/QP99NNJWk6yzW0NIEpEk6Bal/QZf
	 fUl3YgVHINxXiGDqmE3BPTbIm9LkNYM0jPPJAAM4ri5/YbnOpnzaFau+FjymYKgayM
	 9I7g2MgfymcvmsyRWj1xjs+n5rK89WBNLTfzIEojniXHD0rExaINmTBAZnLYuGyyyk
	 Hv79xEp0U6bLQ==
Date: Wed, 25 Sep 2024 10:34:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] clone3: clone3_cap_checkpoint_restore: remove unused
 MAX_PID_NS_LEVEL macro
Message-ID: <20240925-dackel-chatbot-0a01df1e0d6e@brauner>
References: <20240903033628.10306-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903033628.10306-1-bajing@cmss.chinamobile.com>

On Tue, Sep 03, 2024 at 11:36:28AM GMT, Ba Jing wrote:
> The macro MAX_PID_NS_LEVEL is never referenced in the code, so remove it.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

