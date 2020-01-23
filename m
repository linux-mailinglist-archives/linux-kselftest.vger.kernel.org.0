Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C23146F6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 18:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAWRS3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 12:18:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40014 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWRSY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 12:18:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id c77so3612807oib.7
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnQrSbFLZoFzkSjXwKmxPlg8vAGR4Rz7FX09nL1MowQ=;
        b=hc21+PStvyHAkZivbzfWmA/5ihjJevnx3O/tdQzDwujLUH2jxifbQNtwgbRO76pWhB
         Il8sLvHmktBy4VkGrH/ej+5PuXOlCziFAsmd69uOrq3Byko2073ruAuvZCWqvGzTQMlI
         r4BULczhgrkpj2ln6AC+idZbtEaXPsqmIDleo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnQrSbFLZoFzkSjXwKmxPlg8vAGR4Rz7FX09nL1MowQ=;
        b=oLvJJafMNb6wFGwKJnaDQwOXqt11+8Ds9ca2yATMX+0E9D96F+AqWUFbse7sw/nunN
         MvQFCKvVk2x1WJR5TIkb1nxPm5XX6K0Tcxn2mufYeFGlpG//S1zo+7ei4Gtzpa1Zo3y5
         Ug3kvhtcuHRP8b5ApybxtmBHiO7J7aeQKLyE4Hs2pnzzW3O+n2MLVNGwfF/fazFsXMGG
         lwsj8R8otF8XRu/A+6ipFql85iYSon3gfnxYhP66mpKjaTOctmjI/YFA5zX/Vnss+5px
         OUysIm8umCq43mEW55WKsizEyV1+EimIQembYnquOMizlYWroeFLbegzu2R2SUQOcU5l
         TnrQ==
X-Gm-Message-State: APjAAAUt8FuJyw8dsvBSd/LGthstDk5Vlwjiun2h0j2yPDdW/HdkkWXD
        cozuUiCezSrWqH63WNtMat4DzmNkTTtQUzr64pwkBQ==
X-Google-Smtp-Source: APXvYqzalvtZo7H5iCHOLugbV07Wh+3lDL0ZFS+9bcfQzmkeyCF3b8BK8no3VDOS4OA6O0SMek4Z40BUq4KlKxXKVtk=
X-Received: by 2002:aca:b60a:: with SMTP id g10mr10878162oif.102.1579799903847;
 Thu, 23 Jan 2020 09:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20200123165934.9584-1-lmb@cloudflare.com> <20200123165934.9584-3-lmb@cloudflare.com>
 <20200123171612.stdwtlpqibkydz2s@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200123171612.stdwtlpqibkydz2s@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 23 Jan 2020 17:18:12 +0000
Message-ID: <CACAyw999DErydNaDVgczYtqzSP09hnXtmwwJ0kocjisfRdVhxQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] selftests: bpf: ignore RST packets for reuseport tests
To:     Martin Lau <kafai@fb.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 23 Jan 2020 at 17:16, Martin Lau <kafai@fb.com> wrote:
>
> On Thu, Jan 23, 2020 at 04:59:31PM +0000, Lorenz Bauer wrote:
> > The reuseport tests currently suffer from a race condition: RST
> > packets count towards DROP_ERR_SKB_DATA, since they don't contain
> > a valid struct cmd. Tests will spuriously fail depending on whether
> > check_results is called before or after the RST is processed.
> >
> > Exit the BPF program early if FIN is set.
> Make sense.
> Is it a RST or FIN?  The earlier commit message said RST.

FIN, sorry. I'll update in a follow up.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
