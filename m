Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D918DBDE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504371AbfJRG4X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 02:56:23 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45530 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504354AbfJRG4W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 02:56:22 -0400
Received: by mail-il1-f195.google.com with SMTP id u1so4540781ilq.12
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 23:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ezhLxysreTWLbeV3Ebu2jcuzTMqZsioc2qHz8h8rBY=;
        b=X+D2a2SDs8vW2TxAyRfeRdrD4bG5VaqNcKXD6PpZwibJoM56NWHyZFA+9aQ0qrDR7L
         afokFsWMoZzfROr6eFkYxQ7xvEDmI+tnxNFMtFqhTZm6MTT+jSsPPPzULCFwFvY+0/SR
         /68OAyBMXkow8O6zPowzLRpokk/GjByyCzuyHX69BhCbxyJqj1D9La0itxug06lpRfTb
         Y03GzK0FVkSEO5SR2NwsxhpGq4q25WzgW/iWSsHCZ4hPXr/YAdbbr5EIYRiXyXcW9N05
         59XbTYQnjok8bgJV4OtrCZSqV2Q6QGOmsXqA8wfVAGnKFk9s3h8AYKAoyfBA0cTsaADS
         Vhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ezhLxysreTWLbeV3Ebu2jcuzTMqZsioc2qHz8h8rBY=;
        b=TkxJzxd19PQX8Va0rLoi2kJ/HaEC/AXI0puoNZxdpPtVDXipXPZKk4rVHpKWFZcT4e
         JuuQuW9MIAdirJKBrKjtKv7fgPYitNpnWWDrI6tsF+sQ2ikkcws334+heW7WyENkFV51
         bFGJN4RW+YJAFAjL/VCRC/IjJonJJ9mrc86wqLiz6+H+SumdIymHO/wd/RSKhPp17tH6
         jZ1tZjtNNmGQxTbVEjffHiCeHC/HGhjju+2wHLjbrAXpOisBN8lWMJRDGuju06uYuTOe
         Ufi2pnm2ke+Fq9RhQl8askd17ffErWzaOJzwKfkYz416wYf+3DoQri9MkmzsJeCN2cjI
         oyrw==
X-Gm-Message-State: APjAAAVkOAuoQVFCsXFF0Y7NuzbG+kjrw2Ug0NT8+RQbeF/Z5sJMY6He
        5X1CDoB9Wqg/64boHnRXK/RQTGwQ6u7ex9cOb6U=
X-Google-Smtp-Source: APXvYqz9bmzTu9IdDKfRJLbYMS5YbtDNHxAS+4qiXNNbeNHXMV22FQtfZ9Ay+r+8w76dnGgvYxSRQoHZC9S8GY1WD2M=
X-Received: by 2002:a92:98d8:: with SMTP id a85mr8248240ill.98.1571381781812;
 Thu, 17 Oct 2019 23:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <d08b43ee-6a21-c9aa-ea7b-9465ecbad772@cn.fujitsu.com> <05dbae1d-05de-8360-5f3c-a698d4dc3226@cn.fujitsu.com>
In-Reply-To: <05dbae1d-05de-8360-5f3c-a698d4dc3226@cn.fujitsu.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Fri, 18 Oct 2019 12:26:11 +0530
Message-ID: <CAJ2QiJKvUXjC+Ejad3eGiaY8F-UVSnWUPyvbZ46LkE7k0kaZZQ@mail.gmail.com>
Subject: Re: [Bug report] "make run_tests -C bpf" hanging forever
To:     Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Philip Li <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 12:12 PM Liu Yiding <liuyd.fnst@cn.fujitsu.com> wrote:
>
> CC LKP mainter
>
>
> On 10/18/19 2:32 PM, Liu Yiding wrote:
> > Hi All.
> >
> > The patch 5c069b6dedef "selftests: Move test output to diagnostic
> > lines" from Apr 24, 2019,
> >
> > leads to `make run_tests -C bpf` hanging forever.
> >
> >
> > Bpf includes many subtest, when cmd `make run_tests -C bpf` runs to
> > test_lwt_seg6local.sh, task will hang and runner.sh never run next
> > task. I checked ps aux, prefix.pl will never exit.
> >
> > ```
> >
> > 91058 [  811.451584] # [25] VAR __license type_id=24 linkage=1
> > 91059 [  811.451586]-
> > 91060 [  811.455365] # [26] DATASEC license size=0 vlen=1 size == 0
> > 91061 [  811.455367]-
> > 91062 [  811.457424] #-
> > 91063 [  811.457425]-
> > 91064 [  811.460912] # selftests: test_lwt_seg6local [PASS]
> > 91065 [  811.460914]-
> > 91066 [ 3620.461986] Thu Oct 17 14:54:05 CST 2019 detected soft_timeout
> >
> > ```
> >
> > Ignore test_lwt_seg6local and run `make run_tests -C bpf` again, task
> > will hang on test_tc_tunnel.sh.
> >
> >
> > Kushwaha also meet this issue, `make run_tests -C bpf` hang on
> > test_lwt_ip_encap.sh (This test failed on my localhost).
> >

Yes, i also faced this issue on Linux-5.3. if i kill prefix.pl or add
timeout in prefix.pl, test move ahead.

somehow this issue is not present on Linux 5.4-rc3+. It could be by
chance and may show on any other version.

--prabhakar (pk)
