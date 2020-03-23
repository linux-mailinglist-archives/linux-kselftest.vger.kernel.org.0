Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B218FD61
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 20:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCWTQH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 15:16:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45689 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgCWTQH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 15:16:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id o26so1179303pgc.12
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Mar 2020 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ge+SjDt8XkYogl3cRlienjEoLSa3og33Dmi/56o0M7Y=;
        b=O6YzOT8gXPDE40c3wFDECEysSpGx0XiYKlpUNH6HK6QTOlH0Rr9uuJWU3nXcSCLskf
         Xm1MobyG8mOmKWR1hUqAk2YeQzMUyJvKTHvgcbP0dSER7xSiPpRKOjzqox+X3xeRFzbp
         nvwN218YhGqA+LCFyZSuX6rtNGOnpF7E37P83YbVMp4SxuIL+VzczgcPZj6tIlEtHaxc
         Fu8BiQASznTVLr04lZfCAL8qh2blifuz97scL+g76DLa4LIPrZMZzy4TtQHmoznAKBW1
         JwGbNAh7KO6kNSqTtzg8nhszfUp0YaPJUWc4YoBJ0eFapBZ7vztcMN33eVsocV7RJku+
         hDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ge+SjDt8XkYogl3cRlienjEoLSa3og33Dmi/56o0M7Y=;
        b=VMSDMyOvmHqGWhxSOHMPo6E0zcs3LdFI54YAqhskYAqe+MJtLsCaSDXMxcOdklDeGm
         Nl4SJaozFiPnv+JVQFfPV/xSXmNezYaP7cBviXAXeeo0DwHUdfBNkcIMirRIhZmAGTDA
         E1h0iNJIULzOWrrjpQwlZ/MxsWgw0vaa+0ugUkUzo6rQS0AglEkXHeQkD35vHyK/8vYV
         5Wig4OdIAgipUDZcI7GXj7cCmt9K1//V011zqSkO/SdfMg1UdVpjLrq6V0fuT6tSOvpn
         x4jf1kQgJZzK85s5k+PNN0fhGSRqJ6xZ27fbiGUHEW8d04kfyqCjbJclNLL1wuAVZzHY
         dTIQ==
X-Gm-Message-State: ANhLgQ34p3ggkztiEjFIaeVAlNmc2xcxN14/lSBLOZ4o8BrdOsKbX2wC
        ZQuJBRUgt3whxxkBfhocqpms3tTJBeMx8My2JxP6dQ==
X-Google-Smtp-Source: ADFU+vtBoyGtoUKl58MXCCY/B3Ow7q0foDDWrI7P4k8QpSvV/CRLv15jN3ag/N3C5jlQJO2ro27EvpDd0QmG8lXN8ts=
X-Received: by 2002:a63:dd06:: with SMTP id t6mr22540455pgg.384.1584990966098;
 Mon, 23 Mar 2020 12:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200323173653.41305-1-brendanhiggins@google.com> <e5f7db19-4468-8679-9ed1-3565a0adcfc0@kernel.org>
In-Reply-To: <e5f7db19-4468-8679-9ed1-3565a0adcfc0@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 23 Mar 2020 12:15:54 -0700
Message-ID: <CAFd5g46GqBqdrRk6743bnUQyS+yStP3DpkVNWsAMEHDS3i3FBw@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: tool: add missing test data file content
To:     shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Heidi Fahim <heidifahim@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 11:44 AM shuah <shuah@kernel.org> wrote:
>
> On 3/23/20 11:36 AM, Brendan Higgins wrote:
> > A test data file for one of the kunit_tool unit tests was missing; add
> > it in so that unit tests can run properly.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> > Shuah, this is a fix for a broken test. Can you apply this for 5.7?
>
> Can you please add more details on what kind of data this file supplies
> and which test fails if it doesn't exist.

Sure,

This adds a raw dmesg test log to test the kunit_tool's dmesg parser.
test_prefix_poundsign and test_output_with_prefix_isolated_correctly
fail without this test log.

I will send a new revision with this information in the commit message.

> > ---
> >   .../testing/kunit/test_data/test_pound_sign.log  | Bin 0 -> 1656 bytes
> >   1 file changed, 0 insertions(+), 0 deletions(-)
> >
> > diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..28ffa5ba03bfa81ea02ea9d38e7de7acf3dd9e5d 100644
> > GIT binary patch
> > literal 1656
> > zcmah}U2EGg6n$=g#f7|Vtj^>lPBOzDM#o@mlt9+Kgd${FPEBlGBgsqs?{^h<Y3h$o
> > zFBaGLocpP>13GNVmW<8=R3_K%5Q9W*u~4upWe`4q(jqBTdcAw?ZG=v-jA5@FZ|^*5
> > zoU$NALGF+lEFssq<A{~zdHR7p&7+U(X~E!_yGM{l@40vQ%(~pazHH!+GB!sI;iCKZ
> > zY69Cjp-?V{LrnyMQ5I_>Rp5<1_i#FmdPY1z2tkYI|M1-7PdS}Ub_h8eK~m)?&(I;{
> > zd<2<NV1vyl7BWOggn_Hc5ba`wRu)R=x;oPiRuheYD}$9XJTpphG^wKX*mr|pw(;#T
> > zTvPxWb#R&-VC|~9KeFD0ooNCooO~P|@vNKL)n#t&WQm2JSh%gFRMuv7!M#yqYailx
> > z8TM&AUN~yqVM$ThVIE55OcVU4mW$eHC#dHEeUvCiE1wT#?U%cS^A_HAK$VqiIBG75
> > z($V`G!unJPuo@k2@gj4y7$WV7g73Ls@d32giPqc=`3mz^u|IR`05hOx29+=__XXIv
> > z%Xf#6<%P11b*dyatBVv$thED!=x%_Ts?sj1OY%b*t$Y}rODc$J2is^#<A~w+w`~mf
> > zCs_oC7u=9pAjzurLE}*e38}&1-KX^pd*7wM-Q35(VDtTJOgeOnB`K*rii#c_+)*qi
> > zNQ+5Dqv>MG0wcp<uf!}(SCXw)kqXk>xCSP@rQbRs58c`TmTbn>%WO@TFp;w*gB6RU
> > km;Ljlo8cvfMVVCc>`K4bOfE$-fO&T9$C>+RbV7Fh7t6}$ApigX
> >
> > literal 0
> > HcmV?d00001
> >
> >
> > base-commit: 021ed9f551da33449a5238e45e849913422671d7
> >
>
> thanks,
> -- Shuah

Cheers
