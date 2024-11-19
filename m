Return-Path: <linux-kselftest+bounces-22265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882429D2484
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 12:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17569B27527
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BC1C6F71;
	Tue, 19 Nov 2024 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="PxttJcsg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED911C68B2;
	Tue, 19 Nov 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014210; cv=none; b=XfkMAzEI1ny77/KbpnxzdTLJzkR7MhJtgge+c87SL5qgH97jqVMMB+zgiRrlNxDRaRAI9TMC/Jh+2n0lOb9ZTDAEUmXtQaEtrM7bHwOGmODnx1z8lWgiy9L24fUzDXZXpr8oGQAiMTHJ0HwUq7gLEBIedkhmxiR43UmZPYs4s2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014210; c=relaxed/simple;
	bh=aJ5K2q9mqNSqTCgXLexrzoLohS/CKe1+e+l1a0CAFX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VV3woKmIqqg5wYmMnatnRu6YeMJPdEaFOwU1pkjhBoN6Vkp0S817FtdiuTACCh/Q8tX40PGqRpjOvDFJK3bzeTnMaQvwHWkAxbvwdTHcI3TKd0JOW6qmcZWToMkrTTMlf5/LhJM1hjuANnbVJSuB9ZEd9fb5yCga/khPTvXjoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=PxttJcsg; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:339a:0:640:a002:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id D8A89613BF;
	Tue, 19 Nov 2024 14:03:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id H3PcixrOpa60-LLeEi36o;
	Tue, 19 Nov 2024 14:03:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732014198; bh=exOOjxGX9sMW0VLoYv1+HLZua1oxjjGv4JrDpnhbuc4=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=PxttJcsgethQmC8dPISISo6PA4S6ClNmXZMlR4V9AkQnJy0xpeSOcoWS7IUL34zXY
	 Zmw2tPi/zaar7cQ36yHJHiSHDtvxpzNSugDSCS2NGIM8u48eow3UE0Fsf3qLBYq1Tg
	 2ee37Y9Y4XcmkyekWEvxWYMooXBP6ZGJ/ezj7VZs=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <f7fd4a35-3c04-4eb0-a58d-18ed8d7210b9@yandex.ru>
Date: Tue, 19 Nov 2024 14:03:16 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/unix: pass pidfd flags via SCM_PIDFD cmsg
Content-Language: en-US
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
From: stsp <stsp2@yandex.ru>
In-Reply-To: <20241116011038.94912-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

16.11.2024 04:10, Kuniyuki Iwashima пишет:
> Now this allows sending pidfd without SO_PASSPIDFD, so you need to
> add a validation for "if (!msg->msg_control)" in __scm_recv_common().
Will do, thanks.
Btw don't we need MSG_CTRUNC in
such case even if "msg_control"exists? Or the established practice is to 
just drop cmsg silently? I mean, something like the below: --- 
a/include/net/scm.h +++ b/include/net/scm.h @@ -176,12 +176,19 @@ static 
inline bool __scm_recv_common(struct socket *sock, struct msghdr *msg, 
if (!msg->msg_control) { if (test_bit(SOCK_PASSCRED, &sock->flags) || 
test_bit(SOCK_PASSPIDFD, &sock->flags) || - scm->fp || 
scm_has_secdata(sock)) + scm->fp || scm_has_secdata(sock) || + 
scm->pidfd_flags) msg->msg_flags |= MSG_CTRUNC; scm_destroy(scm); return 
false; } + if (!test_bit(SOCK_PASSPIDFD, &sock->flags) && 
scm->pidfd_flags) { + msg->msg_flags |= MSG_CTRUNC; + scm_destroy(scm); 
+ return false; + } + if (test_bit(SOCK_PASSCRED, &sock->flags)) { 
struct user_namespace *current_ns = current_user_ns(); struct ucred 
ucreds = {

