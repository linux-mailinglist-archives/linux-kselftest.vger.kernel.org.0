Return-Path: <linux-kselftest+bounces-43353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8874BBE5738
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 22:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39C224E91EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5272DFA2A;
	Thu, 16 Oct 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="k+Lz5rZB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B0E2580FF;
	Thu, 16 Oct 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647830; cv=none; b=hhnngqZf0WOKNhlJoV1C4jHKQHIT1pvOQXIKin/Zf0vYrC618pUaEn8WzBFKNhWpVY0GW9KK5+oBnxhQ9WiNl3PS3LTpZj/6z0tV3jUokJe4jo43uqIeSAm2uia0mcSdqYdZy+KcLL2oH6uzQ5GNmSVlwLV3xbnis/3G0kAiUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647830; c=relaxed/simple;
	bh=ITlIzUAUo5pssT1lw+5f7WFRnL9FQktvSQ7YkS/Swf4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BO0JUPNAxEmmpdcV5QvnPbWfkm9nFsvHp1IR+6qZP5LrJ0/tj2ddfRR9YNke+Kq3teUt0KdpyvZvjXcnfTAy9hllZqjfpFLx3mAUjSCeFqLIEk3iOmzdvHFRUhu4dP+ZwZ0l6KGvQ5WVpMxUs93YRvUM0tEuz2XRfnMy6Y9MdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k+Lz5rZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA14C4CEF1;
	Thu, 16 Oct 2025 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760647829;
	bh=ITlIzUAUo5pssT1lw+5f7WFRnL9FQktvSQ7YkS/Swf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+Lz5rZBobuGND9FUYtJH8NH5vh9PWxwRUoTE04ieCY9L1ZYOEv6KSowX27XvzdvQ
	 Z3RDm/K4iKRxg0IJDOOqW0Ghs7z6YfksWl1db3oe8w7t5je78shZgX1cFiARrxlpS/
	 ANZCwotNwcmuyftujQphlq2yleXvWJEdvZcSQEcI=
Date: Thu, 16 Oct 2025 13:50:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Lance Yang <lance.yang@linux.dev>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "wireguard@lists.zx2c4.com"
 <wireguard@lists.zx2c4.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>, David
 Hildenbrand <david@redhat.com>, Florian Wesphal <fw@strlen.de>, Jakub
 Kacinski <kuba@kernel.org>, "Jason A . Donenfeld" <jason@zx2c4.com>, Joel
 Granados <joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Liam Howlett
 <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Petr Mladek <pmladek@suse.com>,
 "Phil Auld" <pauld@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Steven
 Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?Q?[=E5=A4=96=E9=83=A8=E9=82=AE=E4=BB=B6]?= Re:
 [PATCH][v4] hung_task: Panic when there are more than N hung tasks at the
 same time
Message-Id: <20251016135028.aea65e20b0bc7efee11572f1@linux-foundation.org>
In-Reply-To: <bb443552b6db40548a4fae98d1f63c80@baidu.com>
References: <20251015063615.2632-1-lirongqing@baidu.com>
	<4db3bd26-1f74-4096-84fd-f652ec9a4d27@linux.dev>
	<bb443552b6db40548a4fae98d1f63c80@baidu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 05:57:34 +0000 "Li,Rongqing" <lirongqing@baidu.com> wrote:

> > If you agree, likely no need to resend - Andrew could pick it up directly when
> > applying :)
> > 
> 
> This is better;
> 
> Andrew, could you pick it up directly

No problems, thanks.

