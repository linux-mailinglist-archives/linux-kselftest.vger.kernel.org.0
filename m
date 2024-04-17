Return-Path: <linux-kselftest+bounces-8271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93FE8A8DF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 23:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653AD2819DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 21:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00636651AF;
	Wed, 17 Apr 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9Dy/zGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4118F4A;
	Wed, 17 Apr 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389324; cv=none; b=NZV+y7s5Lv1LlAjX1GI/Iw3M+Zf9taMzsbXsv742KnoHznbIlK9iJqvS+/7LSB9n3lBtJ4sqyfHaBbrJ1vc5eXzZPYE3DuaA2////Uresa7WrpXp+UaVKPVp8oZBi1nRdHfBVwlHov0HzJEUYu0xRdQo3aYL7+yXscFi3YONULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389324; c=relaxed/simple;
	bh=CcUwRC1ONYjbKMJcsLelzN8dCXZuvmUYbPtOjD1wORI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzgJN9pM2kWZlusBvSWrZKFyiqe5a/QjLS96raKZtjLgLcw0x8q0xRzy5jRKk97bEBiZpze5ecFII+LDhx3Q5TztnEUBL8yGhJmt+SKM+T+z9RnqJUcaN3uhA3cJs41HfeJJ2xo7sRw+LsN89bGuVqdmGhXrCNgo40vmKFSG1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9Dy/zGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F626C072AA;
	Wed, 17 Apr 2024 21:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713389324;
	bh=CcUwRC1ONYjbKMJcsLelzN8dCXZuvmUYbPtOjD1wORI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G9Dy/zGslStluiYRn7O++1NbHg+TqBYAGJ8DDoKpYpx9roNHiKCyzIyjRw95XNMbY
	 RWbKkHVzCQm0Ej/XuQdAv0xjmuFcfyCMXng+pZSMyj73Zh7eS7EVH/fnqtM2NmMcYM
	 TrDLCjn8THg8qjacMX7k3VJhzh59uDT4k86gRmDerfU8oSud49vXrxpR3sRfsw2RCS
	 YejpqSRKNzOPGKhDcOcVRYQVHsjJyQqpLZdFWh6BudeS3OQSP/drseCPAjQ92k3FFg
	 lqJ//dng8qosZsI+hKC7bFLAgmuDqgNbHRCUGrWLFHwFLFQiNCDmrWRpfBkSofX9Gy
	 oayyLMgNCMWtQ==
Date: Wed, 17 Apr 2024 14:28:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] selftests/net/tcp_ao: A bunch of fixes for
 TCP-AO selftests
Message-ID: <20240417142843.27a221f8@kernel.org>
In-Reply-To: <20240417134636.102f0120@kernel.org>
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
	<20240416072809.3ae7c3d3@kernel.org>
	<CAJwJo6Yw4S1wCcimRVy=P8h0Ez0UDt-yw2jqSY-ph3TKsQVVGA@mail.gmail.com>
	<20240417134636.102f0120@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 13:46:36 -0700 Jakub Kicinski wrote:
> > I can spend some time on them after I verify that my fix for -stable
> > is actually fixing an issue I think it fixes.
> > Seems like your automation + my selftests are giving some fruits, hehe.  
> 
> Oh, very interesting, I don't recall these coming up before.

Correction, these are old, and if I plug the branch names here:
https://netdev.bots.linux.dev/contest.html
there is a whole bunch of tests failing that day.

Keep in mind these run pre-commit so not all failures are flakes.

