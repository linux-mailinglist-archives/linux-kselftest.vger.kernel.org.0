Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E34ED02F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2019 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfKBSIu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Nov 2019 14:08:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46916 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfKBSIu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Nov 2019 14:08:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so17562177qtq.13
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Nov 2019 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54ZgFXF79PsoBqwHLd+KFR7DMz/ndkohyJiwLmJud40=;
        b=GLYtsoiOB1E5GP1hzNEsiemcBBuT/Te/w3K3mEwnsNZ34/nCZ/Vfc/dMqaQWtWSlnm
         7Ku0tAgU+n9tXRAdZEM5ud3CEIiD19LW296iQIyNojXuBGA1+n1w5RruUznh9aD8c58M
         BeNrC/xt/jx9K0z0sxlwyLKwtztaGyZ57fwzjEzZyi3+NvEmmgkNWCimuET9kzPdPpsS
         DnDlyPNeBWmn2NWMrDHCzswWhHMGcaaWQ3/ynYxXD6zlXkjCcf7NzxemTurqYZ4u+61R
         u8RrD5FZUXfTCkxG8aF+uPVv/KN7Iq0OwCzDtGMg2PQtLbiOeznaxdlFL2MMJzBuItOq
         LeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54ZgFXF79PsoBqwHLd+KFR7DMz/ndkohyJiwLmJud40=;
        b=fZlfG7WaMWqUHcqqle3Q5TIs2hQyHfgR3LFHiAulSYIcyiTHCOmAtV8EkB2UCbXi1d
         M22OtxWAo5hMqchJv4wz+mPLPjSQ1HeAV4FH0Lt0bS5cjXcQvtxAniu5OFg6R+Gemxgw
         JAN+ErsZmbkPQ213lStpcEvgz5auRQ2OWSRzpBI5ax1h9QQ3HRmtYzbOtZ0EDY/6C0OG
         +BePXn/LOFJEn421DIUXfBnCx+XOo6YR9NYi5brMtAS4P5lIuVPNaFS3Z+447c2ws1FO
         P1FnU9tGeOj7SWtMyRisTDjl2hpQCgRJ8n7S4PjTCR60Hyrl84TRpgPQdG9HgGk9Bzyn
         kEBg==
X-Gm-Message-State: APjAAAVoy77u/HTHmnpROtJQIpry9CwBdkbe7r8otrkoWXpAr+WoyBNp
        OmFVLYK6UAgPxo0HO0NKa/hV1Kizoi5gLKoYnxGAgA==
X-Google-Smtp-Source: APXvYqzM88wsrd+s7vbMPtZBeUcDqswwe/5goYFlqOnnWZnnSOoISL3dBDRySiuDcwDuIgR3C/z9R2Crgkq5xiPBMGc=
X-Received: by 2002:ad4:540c:: with SMTP id f12mr8277391qvt.3.1572718129718;
 Sat, 02 Nov 2019 11:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191101233408.BC15495C0902@us180.sjc.aristanetworks.com>
 <0a03def6-3ea0-090f-048f-877700836df2@gmail.com> <CA+HUmGgDrY9A7kz7268ycAOhExA3Y1h-QhBS6xwbWYxpUODDWw@mail.gmail.com>
 <690336d7-0478-e555-a49b-143091e6e818@gmail.com> <CA+HUmGgKakVpS8UsKWUwm9QdCf+T2Pi1wNS-Kr7NE+TQ8ABGaQ@mail.gmail.com>
 <06dd5c8e-7eeb-a00f-e437-11897fe01ad1@gmail.com>
In-Reply-To: <06dd5c8e-7eeb-a00f-e437-11897fe01ad1@gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Sat, 2 Nov 2019 11:08:38 -0700
Message-ID: <CA+HUmGjra-=GeRApvYRgX6iQZPG73xWyfXqR-_fxjKS0WcmYrQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftest: net: add icmp reply address test
To:     David Ahern <dsahern@gmail.com>
Cc:     David Miller <davem@davemloft.net>, shuah@kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 2, 2019 at 10:38 AM David Ahern <dsahern@gmail.com> wrote:
>
> On 11/2/19 10:09 AM, Francesco Ruggeri wrote:
> > On Sat, Nov 2, 2019 at 8:11 AM David Ahern <dsahern@gmail.com> wrote:
> >> On 11/2/19 9:08 AM, Francesco Ruggeri wrote:
> >>> I am only using macvlans for N1 in the ipv6 test, where there are 3 nodes.
> >>> How do I use veths for that?
> >>
> >> checkout the connect_ns function. It uses veth to connect ns1 to ns2.
> >
> > I apologize in advance  for being slow ...
> > I have 3 namespaces that have to share the same LAN, I am not trying
> > 1-1 connections among those namespaces.
> >
>
> How would you cable this if it were an actual network with physical nodes?
> - bridge on R1 (since it is the gw for H1), with connections to R2 and
> H1 into the bridge
> - second connection between R1 and R2
> - connection between R2 and H2
>
> For the simulation, network namespaces represent physical nodes, veth
> pairs act like a cable between the nodes / namespaces and the bridge
> makes the LAN.
