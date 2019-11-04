Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCF7EE715
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2019 19:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfKDSON (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 13:14:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35479 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfKDSON (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 13:14:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id r22so15253925qtt.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2019 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFyWfFE3vJ2DESlYbVSlpwQ42nAt0NoXwAPERBscrik=;
        b=IF4dVrEjUKzo6XDMsXgXo7FykeX4xiyom7UY/YfLjg4yfXgi9zas+3o75BWIcV7Z8e
         pXTyD5xInQzfym61sVigJzG65tYHnZYQQojzlu5cB7gDDCfixgvz+1FDQGUzBEaKn2ga
         4u17ieX/GisEedjj4XvrkqhE75Q2i3JuPmN8OcsvKhRrHDepG0XV18Pqoyxuhd+BP8Qt
         qHaTomChk4y1nWRqLObsBvRmK+aUcG31pmG/39+mQNkyMNEVeF01Lbb9xsEyXgZFM84m
         8zjnMKwDPEVxp2BOLqoU7co0mMLYwym+m1dv2/MR45aIe88PUBLwwTBND2MzgYU1xsC5
         erdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFyWfFE3vJ2DESlYbVSlpwQ42nAt0NoXwAPERBscrik=;
        b=bo+a80h0DqD3mqTn/1tVh7ZkcOVdtRpAnV/GwzVnlTAiMZ2FX91Z2X/mN/V/b7pcSK
         PzbmXVccMsLWe5nSPxxQyvem7UhpWveTmxoVgXfrbtyp8WZ7tw2qn9y198myvNVaE0ac
         UtFvcOx18yOR9Q8IjooHndsqxdkWPgB+zl34J24fzHLsU0IYVPthdPzQ0ftJULOtkIh5
         eV4TG/e2vapwr+e3qPozh+b5bOvl8DR5EGikYKKgBJqRBq7+cD8e3MwqQbYmz7bBZCmq
         oQT0A0WR9hdFl4GK66lkJ88/op7lX2tKqYOhoh4XG9amyRS9hCBkDQOM7KbrvkAeemLc
         Fvhw==
X-Gm-Message-State: APjAAAWVD2woLq0C6lAQgO2I8nVtLk/P6u42XScp7922XU2miSFoA5de
        Wpiap3NZ8bANngnA4vPH9ppr2WKR9xTvcqjb530kmw==
X-Google-Smtp-Source: APXvYqzk+K+fhKZy9wpukLTYvjMWeeZYBd19LlhuklMYncy/9fOFkZP7FnjqxaY01EtS4AeMMnoF6Zi1NfCtNV6j9c4=
X-Received: by 2002:ac8:458c:: with SMTP id l12mr14097639qtn.300.1572891251966;
 Mon, 04 Nov 2019 10:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20191101233408.BC15495C0902@us180.sjc.aristanetworks.com>
 <0a03def6-3ea0-090f-048f-877700836df2@gmail.com> <CA+HUmGgDrY9A7kz7268ycAOhExA3Y1h-QhBS6xwbWYxpUODDWw@mail.gmail.com>
 <690336d7-0478-e555-a49b-143091e6e818@gmail.com> <CA+HUmGgKakVpS8UsKWUwm9QdCf+T2Pi1wNS-Kr7NE+TQ8ABGaQ@mail.gmail.com>
 <06dd5c8e-7eeb-a00f-e437-11897fe01ad1@gmail.com> <CA+HUmGjra-=GeRApvYRgX6iQZPG73xWyfXqR-_fxjKS0WcmYrQ@mail.gmail.com>
 <CA+HUmGhYzSE-ruiOfQa9UCKcMuN361asxwCD=Nmdjar9jC0bTA@mail.gmail.com> <d07ad847-634f-fcd3-6b8a-77ca29c622d0@gmail.com>
In-Reply-To: <d07ad847-634f-fcd3-6b8a-77ca29c622d0@gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Mon, 4 Nov 2019 10:14:01 -0800
Message-ID: <CA+HUmGhu2-XeCpZ0qzyt2hijLuGi48XqduRecEMk1JpTf+A+9w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftest: net: add icmp reply address test
To:     David Ahern <dsahern@gmail.com>
Cc:     David Miller <davem@davemloft.net>, shuah@kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> The tests are about traceroute in modern networks, not broadcast
> domains. As such, it is preferable for these tests to be constructed
> similar to other extisting networking tests.

Got it.

Thanks,
Francesco
