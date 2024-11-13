Return-Path: <linux-kselftest+bounces-21967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7849C7C72
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 20:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A131F25C92
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 19:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782DE205AD0;
	Wed, 13 Nov 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+xw+UOt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C077201249;
	Wed, 13 Nov 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527774; cv=none; b=Hw+zoTvvMo5KOyMp03PYM7ObcxAFCwLi3MmZ6gz2mmiifMI4hmhpqifeNuHVVxxlucIZyng94JdL5x0RCO/gd704uAhm9NiICeFadRg8gI1OL9kISiRbdZO4Xn2D2V6sJ5WNFevetUsYuhrUihUJca5OwnreKaso6ohoQF6TPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527774; c=relaxed/simple;
	bh=HiWYf4XmNpcuJEW1YX40xC7JRsTt0K/vrpIx16+x7JY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jk3wHXYuShkgJhiV39ZE7YjSdcBSOqdm565itEI/unxuuhkAJaXJb0ext9D9pZgfq9wg+iDR/n4ZUNHvjFWh+nHaQ1V2JVCGD+X9o1ii888U9zo5qRtmOkyw3L+Nl3Hb9awyylHokhA5dUoOy052ijvuXnY4LOqrIMDZyTTp5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+xw+UOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73B8C4CEC3;
	Wed, 13 Nov 2024 19:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731527774;
	bh=HiWYf4XmNpcuJEW1YX40xC7JRsTt0K/vrpIx16+x7JY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l+xw+UOt2SB9hBRTEQvk1i02XxK7whF4rIIYmgzUZodby/ZClKe0s4b2+creOxmOz
	 HVuOHnEQ4DSJaEsbe3l0NyzSRMGq1Cadewhj5bTvFdx1acDevSbNK+LnXrRoBJSFYg
	 yrwGEfOPEzGWD+u9KKulHix3HFT44bsDtniDW3jUcDWPYOaG7Ldj93HxiVOCUHFQ0z
	 fkgMRts7ClElz1LIAVY9PT90bMCnIyjFBfU06hPdRJTIDunXFEJEb9Wyjf2Fs926Ic
	 snvb2EWFI4ZlvZ+5jzBFofxNi1oLBRmAioVYZgJqhqVnOzfbe8leTfFcN3Afe+v/qF
	 o2F5LdFCYaLYA==
Date: Wed, 13 Nov 2024 11:56:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Sam Edwards <cfsworks@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Message-ID: <20241113115612.1717575a@kernel.org>
In-Reply-To: <20241113125152.752778-3-liuhangbin@gmail.com>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
	<20241113125152.752778-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 12:51:52 +0000 Hangbin Liu wrote:
> Add a test to check the temporary address could be added/removed
> correctly when mngtempaddr is set or removed/unmanaged.

Doesn't seem to work for us:

# [+300.25] tempaddr not deleted for 2001:db8::1
# [+0.16] tempaddr not deleted for 2003:db8::1
# [+0.07] FAIL: mngtmpaddr add/remove incorrect
not ok 1 selftests: net: rtnetlink.sh # exit=1
-- 
pw-bot: cr

