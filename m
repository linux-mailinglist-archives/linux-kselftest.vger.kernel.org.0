Return-Path: <linux-kselftest+bounces-7496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2944589E037
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86E42876B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF5413DB92;
	Tue,  9 Apr 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW1euh0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754F13D8AE;
	Tue,  9 Apr 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679551; cv=none; b=KNNVJsUJzlCmQKhFohhIPvQGcj7nz7KDNKmml/AHytpz1GkTsc2TJapb1+Sb9ochJvrXyJDNgAwLWT18uo29sCrx5Qn7vhUQT+pwKRGKfGMql3PIjV6O2raPUB1InQ9JIZUCmNWPF6IC5ieYP5xEsE2I0Ys+EcILF23Bgc46SlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679551; c=relaxed/simple;
	bh=4JA91ZomC1F9gIH8hPeUSsmlXFER3d8hXjEQUbkIWmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3P6NpRcnkOxc+/ABb/aZWs5KmRbhX6T03NeoPJWeggMCPAURlBAFmzq/HbcVlk+MXBOW0UraDlBbGcwS3ocTe0dyA5M0BY7Zxpz80nO4isj9EoW5yz1ipbly5B8JxgkEsxiSDAJ9Gs3SH2wtYmfCmex2XTzOrkgcYySsb9jltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW1euh0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC9FC433F1;
	Tue,  9 Apr 2024 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712679550;
	bh=4JA91ZomC1F9gIH8hPeUSsmlXFER3d8hXjEQUbkIWmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LW1euh0I+dWywAgQ26Yo0y2oBshyPvXrdxRtX/PNPnvDLQK8avZxEShOYGDtjDl6v
	 YT60awapBBcUCTygo0ly+NEKh8sXnMSKJdAV2GP97yyu6jYaN6abozxXsCL4AbjXV9
	 FBtvVE3IPIxaOiPVFNy4E+s8bEdK0ZaF70BWTOP0LwwxRkHTUlfUp17fGQQBYVFQ5Q
	 dAABpQBN5oMHSabnhjXTvYtDznGq741kiiJul3IG3I8M8l6sb2C7heiktjDs9JT4vc
	 N6Qm1PqB05oFPbLWFGc+7g3vyF0l7Zag06VAeJ9P/w49DO7vlwpSLi4QdzDHoQvMph
	 jm6joZo4iWh0g==
Date: Tue, 9 Apr 2024 09:19:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
 eddyz87@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] selftests: move bpf-offload test from bpf
 to net
Message-ID: <20240409091908.21296831@kernel.org>
In-Reply-To: <ZhVoXIE9HhV5LYXV@google.com>
References: <20240409031549.3531084-1-kuba@kernel.org>
	<ZhVoXIE9HhV5LYXV@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 09:10:04 -0700 Stanislav Fomichev wrote:
> Acked-by: Stanislav Fomichev <sdf@google.com>

Thanks!

> Far too often I've seen this test broken because it's not in the CI :-(
> Hope you can put it in the netdev one so we get a better signal.

We use kselftest infra directly, so they got auto-included.
But I gotta investigate what's going on on the runner because 
it seems to be failing right now:
https://netdev.bots.linux.dev/contest.html?test=bpf-offload-py

