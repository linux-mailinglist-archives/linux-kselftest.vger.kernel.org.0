Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21EB81AC04
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2019 14:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfELMYw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 May 2019 08:24:52 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:49744 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfELMYw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 May 2019 08:24:52 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x4CCORKO014335;
        Sun, 12 May 2019 21:24:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x4CCORKO014335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557663868;
        bh=1O7gRxONL8iHqOmucP758iaO2XNRJv2cBvbJJ8bnol8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ODe8Af0MHyy7TvQ9Cxhu/PCI59RLGHLrrZi+5yp7018BSF9HKtc/Dqk3MfCc6Gxkz
         qB+m0QmUm3c9+kiOrE2d7kFjcoPqhlcPkd6038G8AS6Ejz6hFBY/xd3V/dlAv07xB/
         NJspI9ygx8Ky5nP30eSun7Y0RlQF3ldixt4bgL7NACkYggXTvcQ+pEQYB8WTXez9yy
         YPIOAJZ6p+PV10bwgnkUDExJmfkE5TM5gPG0+iyt1o3y9m7dcly7ihMGLIiIANL2Qm
         BQokkSf/CWeOCJ0WIuJWC4Sv2ZyK5NxEvyZittxDXqNrtYcVwC22MD0ZpqpjdnO22F
         xaYNYYlU7qrRw==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id c76so6373642vsd.3;
        Sun, 12 May 2019 05:24:27 -0700 (PDT)
X-Gm-Message-State: APjAAAX+0uSmnyWi76Y8cQrUUWqbkaxdHJTG/9m7L1Qmaw1bRjLxJs4P
        zR9jv90GZ/jGW0O4u/afT6tcw3qG1ywWauSIviM=
X-Google-Smtp-Source: APXvYqz2//FsMfDkqbOJU9yqd80At7R7tO37xWUwTT6n77c+ZlwpROGiJTlhH4454rDGqZOzZMg/+TrVY8nZiKkSVyQ=
X-Received: by 2002:a67:f443:: with SMTP id r3mr10983744vsn.179.1557663866522;
 Sun, 12 May 2019 05:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190508191341.GA17963@redhat.com>
In-Reply-To: <20190508191341.GA17963@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 12 May 2019 21:23:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJr8CSWo-yE-YBq085Y=k+x8X-gQopJLRkxTueP4LGmw@mail.gmail.com>
Message-ID: <CAK7LNASJr8CSWo-yE-YBq085Y=k+x8X-gQopJLRkxTueP4LGmw@mail.gmail.com>
Subject: Re: Build-time tests?
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 9, 2019 at 4:30 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> Hello kbuild, kselftest,
>
> I've been working on a patchset which adds an additional build script to
> the toolchain when compiling livepatches.  There are a few kernel
> section features in which this script does not yet support, but can
> detect and abort when it encounters.  To test this detection, I've
> written a small set of kernel modules that require such sections.
>
> A few questions:
>
> Is build-testing out of scope for kernel selftests?  For expediency,
> it was really easy to spin out new lib/livepatch kernel modules.
>
> Does kbuild support the notion of expected failure?  In this case, the
> build script returns a non-zero error and the build stops.


If I understood correctly, your are asking about kselftest,
maintained by Shuah Khan.

(Unfortunately), makefiles under tools/ adopted completely
different build system, and it is out of scope of kbuild.


> Am I trying to fit a square peg in a round hole?  I could easily keep
> these build tests in a private branch, but could they exist in a
> different format somewhere else in the tree?
>
> Suggestions welcome,
>
> -- Joe



-- 
Best Regards
Masahiro Yamada
