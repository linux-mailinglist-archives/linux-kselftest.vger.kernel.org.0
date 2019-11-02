Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFF3ED0C9
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2019 23:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKBWIb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Nov 2019 18:08:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35615 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfKBWIb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Nov 2019 18:08:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id r22so8035322qtt.2
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Nov 2019 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReWOzS/L1ng/k4/EsPr93pQFZeEIdR8roThMByBKu1Q=;
        b=eo/aq7B+qomkTPDGIjpnvNJnC6/OGOcikdHnaR0C8i7FQdW0E6CE7BZwx6j7bG/2M1
         3FSXf+xfSi6X+hRrgnwv23ido0wOYJrVUALtgo3I/1DHVCB/2aj25B3F3aiza1CFVtRc
         F2KdMKi0TaRaWXAccLy/LSI7TGmAj/DcDoz7OUnQYX4Vvt//zp/48nj2/hPO64WPhaL3
         DQj+LWZAM0apGjkDUlN81cKxmiHBTxwUXxAfshhkQ5BcO58ZnMA3Ur7HmW5mbdUc7e07
         iFSRhRmIrPTnzzbq7cHBUo16p22wHEW5tnqOwWu6kH9kEEA6QXm0+k3vJt7ZfJpuZfzT
         okHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReWOzS/L1ng/k4/EsPr93pQFZeEIdR8roThMByBKu1Q=;
        b=YYKUo5ih4mqCST1KKoGBKcVDrOU2CJw6JiV+/YmoxwT9Q0GUZdOcvelpabPho4w0oP
         CeZARDTL5X3K4j4kIhCSAFGWag+vIrsrcSw4R+Jpqf9MB5bGzpPHIFlQfup741RaSRNh
         HVBEIRMWVc3fyexHYqiTsoaxiP/c2PhZp/Ex3/VCqoTcOcMCFII/YJulVpWF/5eYAeWR
         8h77snC8znbnOghDut7rs3qTByvS70yJsq13anjeH7uu3VZioaLBTU+ERSZjBtVXs5+y
         AufQlmrSw1B7CjOjoFhK38dN4S1rGAfQ+RZlJOeAIu3d1fPTV+pZXDG5z1AB24QWAs8c
         mNmw==
X-Gm-Message-State: APjAAAVRmkoe9AuVNBGXZr/nUJ00WX5qB4/V6VpQqBsQFDx6QjLoxc42
        6iILY1N/6mqph0orTRWRvyw4kH21DRIE/VWOcIZksg==
X-Google-Smtp-Source: APXvYqwb8AH1vU4yDa669yQgSzVbSjaByFk0GcjQC9Z8rhbeanHl/ISlAr5AqZ37OFFF0Np7DAjuih2eAvA+KpHzQAw=
X-Received: by 2002:ac8:109:: with SMTP id e9mr6470687qtg.233.1572732510445;
 Sat, 02 Nov 2019 15:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191101233408.BC15495C0902@us180.sjc.aristanetworks.com>
 <0a03def6-3ea0-090f-048f-877700836df2@gmail.com> <CA+HUmGgDrY9A7kz7268ycAOhExA3Y1h-QhBS6xwbWYxpUODDWw@mail.gmail.com>
 <690336d7-0478-e555-a49b-143091e6e818@gmail.com> <CA+HUmGgKakVpS8UsKWUwm9QdCf+T2Pi1wNS-Kr7NE+TQ8ABGaQ@mail.gmail.com>
 <06dd5c8e-7eeb-a00f-e437-11897fe01ad1@gmail.com> <CA+HUmGjra-=GeRApvYRgX6iQZPG73xWyfXqR-_fxjKS0WcmYrQ@mail.gmail.com>
In-Reply-To: <CA+HUmGjra-=GeRApvYRgX6iQZPG73xWyfXqR-_fxjKS0WcmYrQ@mail.gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Sat, 2 Nov 2019 15:08:19 -0700
Message-ID: <CA+HUmGhYzSE-ruiOfQa9UCKcMuN361asxwCD=Nmdjar9jC0bTA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftest: net: add icmp reply address test
To:     David Ahern <dsahern@gmail.com>
Cc:     David Miller <davem@davemloft.net>, shuah@kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> > > I apologize in advance  for being slow ...
> > > I have 3 namespaces that have to share the same LAN, I am not trying
> > > 1-1 connections among those namespaces.
> > >
> >
> > How would you cable this if it were an actual network with physical nodes?
> > - bridge on R1 (since it is the gw for H1), with connections to R2 and
> > H1 into the bridge
> > - second connection between R1 and R2
> > - connection between R2 and H2
> >
> > For the simulation, network namespaces represent physical nodes, veth
> > pairs act like a cable between the nodes / namespaces and the bridge
> > makes the LAN.

Thanks, I see what you mean now.
I was assuming a different physical model, with all the namespaces on the LAN
connected to a hub (simulated by the dummy device). For simulation purposes this
model seem simpler: there are N interfaces instead of N pairs, and one does not
have to deal with the bridge end of the pairs.
Why is the model you described preferable?

Thanks,
Francesco
