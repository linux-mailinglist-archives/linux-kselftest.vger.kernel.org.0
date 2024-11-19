Return-Path: <linux-kselftest+bounces-22266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3509D248D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 12:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23832287061
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABCA1C3302;
	Tue, 19 Nov 2024 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="el/LTpl8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44B1A9B24;
	Tue, 19 Nov 2024 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014295; cv=none; b=gV1FbCZd3+nHEw4V2LVO1CJkIuMWgFSsPHnkvi3VK02MojtlJif22NNaXOut3nb7DJnKyWRLWMDnwpBZ6SNo1oGVjKHiOFRAhrw9jjHQBjiRM3Wo1F4/IywKfiv0RXMatjV9zH9U6CD/VZV6cWmBRuLInGQoNSgGL3N/tagoEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014295; c=relaxed/simple;
	bh=/SYL9YbS6GATrA0PjR2LaEJi7M8ZYPBqjDcB5/e5lWA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P3tMYqS9Z5KUywQxiM02Qkjvn5Yb7YnUgVTJ9t5ybillYR/50A7KO0jfu3mmVTooaZWwpp4J1+GvIeqBrc41SjMrusl4oNBlHuKGgfixgqDkL37qE8mmWm2Otg77iJKlAHdYsv33oCymKemuLQyLonAo5CznVmAQM5ue+9943Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=el/LTpl8; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:874b:0:640:bc97:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id B8F48611D7;
	Tue, 19 Nov 2024 14:04:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id f4PlBZmOjuQ0-1kWMGczu;
	Tue, 19 Nov 2024 14:04:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732014283; bh=PlfJvw3vZ0B7dANA7HsxSHEs+NvmIVeH1x4Q/ETIw7U=;
	h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
	b=el/LTpl8wCPFL0hrUZ3zY/XZ6fFV6uX+PX7JM080sImHuiOFQ79BD7EuvIN24KheS
	 SvWskZgwfOLIatlCQvOxwZIaxSoY4ixUjbZv7W8rzkHlqF7kPMHNUgoESF9fUjeCcF
	 n09RfKn8xAVSG6thQpo23Y1/aQ9u8bcsB0UXk3sA=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <67638eaf-3d94-450a-8280-df4f7dc66ce7@yandex.ru>
Date: Tue, 19 Nov 2024 14:04:41 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: stsp <stsp2@yandex.ru>
Subject: Re: [PATCH v2] net/unix: pass pidfd flags via SCM_PIDFD cmsg
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, axboe@kernel.dk,
 brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net,
 edumazet@google.com, gouhao@uniontech.com, horms@kernel.org,
 kees@kernel.org, krisman@suse.de, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, mhal@rbox.co,
 netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com,
 quic_abchauha@quicinc.com, shuah@kernel.org, tandersen@netflix.com,
 viro@zeniv.linux.org.uk, willemb@google.com
References: <20241114091909.3552288-1-stsp2@yandex.ru>
 <20241116011038.94912-1-kuniyu@amazon.com>
Content-Language: en-US
In-Reply-To: <20241116011038.94912-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

16.11.2024 04:10, Kuniyuki Iwashima пишет:
> Now this allows sending pidfd without SO_PASSPIDFD, so you need to
> add a validation for "if (!msg->msg_control)" in __scm_recv_common().
Will do, thanks.
Btw don't we need MSG_CTRUNC in
such case even if "msg_control"exists?
Or the established practice is to just drop cmsg silently?
I mean, something like the below:

--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -176,12 +176,19 @@ static inline bool __scm_recv_common(struct socket 
*sock, struct msghdr *msg,
         if (!msg->msg_control) {
                 if (test_bit(SOCK_PASSCRED, &sock->flags) ||
                     test_bit(SOCK_PASSPIDFD, &sock->flags) ||
-                   scm->fp || scm_has_secdata(sock))
+                   scm->fp || scm_has_secdata(sock) ||
+                   scm->pidfd_flags)
                         msg->msg_flags |= MSG_CTRUNC;
                 scm_destroy(scm);
                 return false;
         }

+       if (!test_bit(SOCK_PASSPIDFD, &sock->flags) && scm->pidfd_flags) {
+               msg->msg_flags |= MSG_CTRUNC;
+               scm_destroy(scm);
+               return false;
+       }
+
         if (test_bit(SOCK_PASSCRED, &sock->flags)) {
                 struct user_namespace *current_ns = current_user_ns();
                 struct ucred ucreds = {

