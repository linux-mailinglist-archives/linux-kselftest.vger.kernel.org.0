Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558A1F61CE
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2019 00:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfKIXF3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 9 Nov 2019 18:05:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45584 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfKIXF3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 9 Nov 2019 18:05:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id z4so7546213pfn.12
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Nov 2019 15:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dirWlcLXMWe4DBJFlhecKvrzQebSxo/FvEC+4dhxwKo=;
        b=MUH40SXXiPqYO6J2DJEs7PwCT3R9HKOCxq1wGj4LxBXEYM2tJsthus8hybdFVP2N4s
         JrZhtBYV8v3Yrxp2Xz0307K4Dvn6rwC+LNd6PqSi/ly55v/rXnhwZ5FvUS7+MLFAlTBu
         fIOiXEYyXjNk46oW3WH12DzNfYusV/J7tc7kVSfRrJjvX02+5hQ7f/zd6eFQ38hEqkH/
         NHhOqOxBAcq/eEqIkUwO9w6v0nL12nDN7B6V2G+Rc2em6jAtDipPEWZPKBFjgN8oZMrl
         rjn1sDa5d0ZbDtulAff0lT5anwAgnfPDUWL3+QMXWQFHJH3auzM8ajqkANw6Eld2ySVO
         vMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dirWlcLXMWe4DBJFlhecKvrzQebSxo/FvEC+4dhxwKo=;
        b=PnXuWuBP4RxRpaaYDNkLXFXNB2mYlBPLIYQNSeIGAmzMlBMODhYC8yIVnLYLG2x7xM
         6h1X0rgTmwssKNmLN34k0wQ+CiFiZs/qmZXKCzZBemc4n8E3m+ABMhZ72DQDuxLlTDgF
         subWp4AO2pTqNboGHEPF2OrhGYkf3Pii14i6BMRYYxbDqhLxHpu6Z92UWNJWw8p/93wd
         1VBa8BZf8lcfenZypAe1Nvc8gfNe0cE2A0EHVh1Io/b9dXR3RjXCITwEqH1KSHcS+wQ+
         0WA3OUpMBTyIpkPCh4Yu9DjQ5AUYYiPMzigJn5hPd3I2fOU+ZNQSST3nF7SgHnl9B6uB
         vtxQ==
X-Gm-Message-State: APjAAAXovyYSrFTumTRjjqXQEAkh83KkoW6BI/M8sSm1RQTb/kQ2E6cs
        EZq9y+z6KnKB/PI7PVQn8IIPxw==
X-Google-Smtp-Source: APXvYqydfzMdW+XGC8XiXFGzeGQvDbPZAp7+qG1LcX1F/4qpg1fQnSwlnhv4MEQrG7+7nFgozJR6Dg==
X-Received: by 2002:a63:644:: with SMTP id 65mr12050858pgg.306.1573340728005;
        Sat, 09 Nov 2019 15:05:28 -0800 (PST)
Received: from debian ([122.174.231.44])
        by smtp.gmail.com with ESMTPSA id i123sm16325565pfe.145.2019.11.09.15.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 15:05:27 -0800 (PST)
Date:   Sun, 10 Nov 2019 04:35:20 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     davem@davemloft.net, willemb@google.com, xiyou.wangcong@gmail.com,
        fw@strlen.de, jakub.kicinski@netronome.com,
        john.hurley@netronome.com, pabeni@redhat.com, brouer@redhat.com,
        bigeasy@linutronix.de, jonathan.lemon@gmail.com,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: objtool: skb_push.cold()+0x15: unreachable instruction
Message-ID: <20191109230520.GA22258@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hello,

i got a warning during kernel compilation.

net/core/skbuff.o: warning: objtool: skb_push.cold()+0x15: unreachable instruction

related clips...

--------------------x----------------x---------------------

(gdb) l skb_push.cold
1880	void *skb_push(struct sk_buff *skb, unsigned int len)
1881	{
1882		skb->data -= len;
1883		skb->len  += len;
1884		if (unlikely(skb->data < skb->head))
1885			skb_under_panic(skb, len, __builtin_return_address(0));
1886		return skb->data;
1887	}
1888	EXPORT_SYMBOL(skb_push);
1889	
(gdb) l *0xffffffff815ffc8e
0xffffffff815ffc8e is in skb_push (net/core/skbuff.c:1885).
1880	void *skb_push(struct sk_buff *skb, unsigned int len)
1881	{
1882		skb->data -= len;
1883		skb->len  += len;
1884		if (unlikely(skb->data < skb->head))
1885			skb_under_panic(skb, len, __builtin_return_address(0));
1886		return skb->data;
1887	}
1888	EXPORT_SYMBOL(skb_push);
1889	
(gdb)

------------------x-----------------------x------------------------------------

$uname -a
Linux debian 5.4.0-rc1+ #1 SMP Sat Nov 9 21:29:48 IST 2019 x86_64 GNU/Linux
$

this kernel is from linux-kselftest tree

---------------------------x-------------x------------------------------

$gcc --version
gcc (Debian 9.2.1-14) 9.2.1 20191025
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

-------------------------x-------------------x-----------------------------

Linux debian 5.4.0-rc1+ #1 SMP Sat Nov 9 21:29:48 IST 2019 x86_64 GNU/Linux

GNU Make            	4.2.1
Binutils            	2.33.1
Util-linux          	2.33.1
Mount               	2.33.1
Linux C Library     	2.29
Dynamic linker (ldd)	2.29
Procps              	3.3.15
Kbd                 	2.0.4
Console-tools       	2.0.4
Sh-utils            	8.30
Udev                	241

-------------------------------x-----------------x----------------------------




--
software engineer
rajagiri school of engineering and technology
