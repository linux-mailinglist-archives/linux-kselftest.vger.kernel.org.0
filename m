Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55EB14718
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEFJED (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 05:04:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45380 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfEFJEC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 05:04:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id u3so3177305oic.12
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3CwerUbOgOXXiCSnS9RlnGeZVnQdj5otMQLyftCR5U=;
        b=e+nL3WusVlSphHxBUuOnwpeLcTbcxkM3d0tJwFVnHeQxPP67ruHIlvq20gXdKZhu2H
         bB9lDEUqhP1wiSu91mOioGKtT4ycBoUxoh4FC+hVoBp2F1BbODAaUF2mKyUrYhOAKqit
         T2YBO051njEtXYukqn8B+THQu9IDpG8A3FVKKTOi4pDJ7oz0d7KTjVHPE8z2o4ACwsE9
         ykptic7rc2BJziW9//fZQROuPUNapGoh5nZURetTsM9RFF/vX1CnGbAUdl8YpJIBiHYh
         HGrZrCbs8q8pyJ0vRF0MLBvicTMU2fCeAXdJWGTYB+VAAWlNl7nlXw7CpLz/tNO1+YWN
         PWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3CwerUbOgOXXiCSnS9RlnGeZVnQdj5otMQLyftCR5U=;
        b=Kkh2McriDkOHJLh4fmk+D3JlKTiJSpgemWAww9xxASnJkjLaex2NwENYfMjHXCLo+t
         ozzYgZG8Aow0dMKFGUpNMHk3S3O+CMdaJywjfse4CjbtWEd2k/RPwR7BaOj2cAJwlljd
         smq8/TAT/B9BH3WeghejagqExoz8I2MRLyZ10Tu3n8sC5e2hQrQcc28Ce9rEemql+upc
         R3xDshe2+EY/zIWpE/sJxRvnRXf4uVWazFERoZaEc75T9pW97Ck7BarIK3C9tT2T9ux7
         Vmu+Idc4XaU4KiLYrSGI9XclPvw65Z9a6SD57vUjfUswoEpu5utoMoH/Am9cr/d7pixf
         VZSw==
X-Gm-Message-State: APjAAAXbTtzqR9bNuEWzxzpm+E5lwrjU4YpLTUrEgkvasUOeGC1rCYyb
        I+ghQ3oZZPiQ1KdrtsUVJhOxyhzpa02w0DmeqyGV/g==
X-Google-Smtp-Source: APXvYqwEoyQ/+gdbpiq96mf1vlv5hUoY2bhtp6ecuZwu3ufRDNiX4lPMqoN7zAZpCfyk7yZAb5CAmenmXz4Vrtgwk5I=
X-Received: by 2002:aca:d4cf:: with SMTP id l198mr457112oig.137.1557133441163;
 Mon, 06 May 2019 02:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-12-brendanhiggins@google.com> <8c37fd20-859c-9c34-4465-8adfcfdaab09@kernel.org>
In-Reply-To: <8c37fd20-859c-9c34-4465-8adfcfdaab09@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 6 May 2019 02:03:49 -0700
Message-ID: <CAFd5g44q3qyahykujDzOoO01DwGMUm+Kce-tOAzSW90U4mQM7w@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] kunit: test: add test managed resource tests
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Avinash Kondareddy <akndr41@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 3, 2019 at 7:34 AM shuah <shuah@kernel.org> wrote:
>
> On 5/1/19 5:01 PM, Brendan Higgins wrote:
> > From: Avinash Kondareddy <akndr41@gmail.com>
> >
> > Tests how tests interact with test managed resources in their lifetime.
> >
> > Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> I think this change log could use more details. It is vague on what it
> does.

Agreed. Will fix in next revision.
