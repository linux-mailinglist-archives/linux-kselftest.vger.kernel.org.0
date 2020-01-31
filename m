Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C754D14EF38
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 16:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgAaPKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jan 2020 10:10:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34954 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgAaPKU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jan 2020 10:10:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so6882606otd.2
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2020 07:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/xXQBacUD2LT8kSykWMZ7/iwuqhb5D7McardiSYKME=;
        b=JUFWKDQBUMYZ+0Y15MzGZH1cBQT2UEcvEfM4E0GwkSULZlsWxrkdc7pJzG02OgilmU
         vdaLyfpR+04czvv95l9J4nzOUDUqm9wFLgK5o3sNq/sW/FlkivfpWsBzyzCE8JNoIZAt
         IqWiwgC8QoZQbQkpYIf5rI33i+H1jfEz9FyDBIcOO+eQmV7aA5nmdCnnD7GowP4yLloB
         TZxqlOahpyf1I9Rc008vBmQ48VkwK1+XLR6jAz0q3au80nCO4PBrCjhmOmRYfPnVDpXp
         tZFeMav43caGNzk+zne9P5gm7wPI3qnG21TpVjNKLX2amGfSOkgvpFcI6bKNmXPTFQwj
         Jofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/xXQBacUD2LT8kSykWMZ7/iwuqhb5D7McardiSYKME=;
        b=HmLr3QHPCUVHHF2mrSMhPtsKR0PIq3IwoCP++Lk8xvSzZrTD72AO4EWVwG5ILmqp9w
         3PmjCmCVs4zf7MQTUBvTtOtNJn3NTMBqebLJ7mWpICwYl/W8QpTJWT7ctX3HHqT3dNMJ
         6nKzrhk2UkcR715AyIDqbCZZ92FbbnjFbZSLnll9MJiZfkVbgr7XFsBLzI6HjlN3+53D
         ga4xjLESC9hr5jDRHbjfra6ybPsUxkxNY+Qp7obXpFyc5JNQYweipYzkgaKkcBNOzhOz
         lxgHJhAhYkPD+avAos7CkCqrRC3fTRDSa6UivFC9MkwbjIaUMNg0RqXAiqz1X28vxBTn
         vYRQ==
X-Gm-Message-State: APjAAAUxzXg/eoNBh3gUfCu116tt8G3XngQc+R2LNcsLEnbVfoSV51wK
        +bc4cKqhieW1OLJgcjWb+cgNcsQ0Gy1Y6uSnzYaloA==
X-Google-Smtp-Source: APXvYqzdUKbLLFfbg0yUNrwjz7Px+wdEBBUAVUZlYOtmTmp4jvGH53EmoZv1kff+Lskv6SBX/aOHDRpmoh9H+TeRGFQ=
X-Received: by 2002:a9d:7315:: with SMTP id e21mr8319157otk.255.1580483419727;
 Fri, 31 Jan 2020 07:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20200131122421.23286-1-sjpark@amazon.com> <20200131122421.23286-3-sjpark@amazon.com>
In-Reply-To: <20200131122421.23286-3-sjpark@amazon.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 31 Jan 2020 10:10:03 -0500
Message-ID: <CADVnQyk9xevY0kA9Sm9S9MOBNvcuiY+7YGBtGuoue+r+eizyOA@mail.gmail.com>
Subject: Re: [PATCH 2/3] tcp: Reduce SYN resend delay if a suspicous ACK is received
To:     sjpark@amazon.com
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, shuah@kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, sj38.park@gmail.com,
        aams@amazon.com, SeongJae Park <sjpark@amazon.de>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 31, 2020 at 7:25 AM <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> When closing a connection, the two acks that required to change closing
> socket's status to FIN_WAIT_2 and then TIME_WAIT could be processed in
> reverse order.  This is possible in RSS disabled environments such as a
> connection inside a host.
>
> For example, expected state transitions and required packets for the
> disconnection will be similar to below flow.
>
>          00 (Process A)                         (Process B)
>          01 ESTABLISHED                         ESTABLISHED
>          02 close()
>          03 FIN_WAIT_1
>          04             ---FIN-->
>          05                                     CLOSE_WAIT
>          06             <--ACK---
>          07 FIN_WAIT_2
>          08             <--FIN/ACK---
>          09 TIME_WAIT
>          10             ---ACK-->
>          11                                     LAST_ACK
>          12 CLOSED                              CLOSED

AFAICT this sequence is not quite what would happen, and that it would
be different starting in line 8, and would unfold as follows:

          08                                     close()
          09                                     LAST_ACK
          10             <--FIN/ACK---
          11 TIME_WAIT
          12             ---ACK-->
          13 CLOSED                              CLOSED


> The acks in lines 6 and 8 are the acks.  If the line 8 packet is
> processed before the line 6 packet, it will be just ignored as it is not
> a expected packet,

AFAICT that is where the bug starts.

AFAICT, from first principles, when process A receives the FIN/ACK it
should move to TIME_WAIT even if it has not received a preceding ACK.
That's because ACKs are cumulative. So receiving a later cumulative
ACK conveys all the information in the previous ACKs.

Also, consider the de facto standard state transition diagram from
"TCP/IP Illustrated, Volume 2: The Implementation", by Wright and
Stevens, e.g.:

  https://courses.cs.washington.edu/courses/cse461/19sp/lectures/TCPIP_State_Transition_Diagram.pdf

This first-principles analysis agrees with the Wright/Stevens diagram,
which says that a connection in FIN_WAIT_1 that receives a FIN/ACK
should move to TIME_WAIT.

This seems like a faster and more robust solution than installing
special timers.

Thoughts?

neal
