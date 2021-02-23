Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62183230B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Feb 2021 19:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhBWS1n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Feb 2021 13:27:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:57903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhBWS10 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Feb 2021 13:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614104726;
        bh=7BwauqzseaTyIv+FEED6OWAW8L+89S2yvXr2FlbloOg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MLNYC3zGXzDgsbM3c0876/8kOGG0gHU/UGNDMXvegCA6/mPcQE0doq8KJPREwjocq
         wKGf5BplZCB71qLCwM/Qj6ANgTMA4T56r5YNUBMwsIBCF5iS9X4sqgv5mSctj/uL1S
         HXcelzyqZdLqqcLKLkBl/GsAQ8XVhzBMwaEWO9i4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRCOE-1lQfbd3xtk-00N6Fb; Tue, 23
 Feb 2021 19:25:26 +0100
Date:   Tue, 23 Feb 2021 19:25:22 +0100
From:   John Wood <john.wood@gmx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/8] securtiy/brute: Detect a brute force attack
Message-ID: <20210223182522.GC3068@ubuntu>
References: <20210221154919.68050-1-john.wood@gmx.com>
 <20210221154919.68050-4-john.wood@gmx.com>
 <4fde79a5-34fe-fd27-b390-e9fd341996fb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fde79a5-34fe-fd27-b390-e9fd341996fb@infradead.org>
X-Provags-ID: V03:K1:EUnrf02szRc5Cqg5XwMwv/sMzB3gfsToWIiEyS9CekvrC53uTdW
 t59mo8duYbPIRThpEohuJip1uhwu1DJhuqG2cNQhnv1cIAbROcZ1f5NPYIH3SaCNLUI1M6S
 71swv5a323RzfN5z9qw5VsoFWad1SgMtCg0kGQhPgpupa37a5o/kgDgvcLnhwZOKhCzikmU
 K4yzL2hWJPLGFIa+VsqrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H+7ThYesxAY=:Kh4IJ/yOba6KfzReGlAiOa
 3aU6pjviDfczfe+aZ5o0E6I5Mn2VGR7cFA/IcPxQDNnqWOAFnVu6JbmiswU/6OrOdivKrxKqv
 4Xc91AkaYXTCDPMdshfiH2fImMVGIk4GJ6J3xVJhYQlfGChkb+3/3aPvT1Gu0f2frCUQyI2o8
 1CUQgsp8OxX3EjPhguF9OEIVOhP5pcXmsXzE04SEqICvGbsMIoehrwP7s+ssU4z/09QA4obpr
 HY394T8chXp+7JZMjvLcRTnO9OxMrA7hWsOYPe/lBBdOgTfhY9rta/g9djDzO60bZ+kz5zKrY
 gAtP+hi2P+Tq47xG2MitQRPczKIV/k0tiRDIWlxJR5RVUzOuPT8R9w3ULGOqVUYPHsO9Z714B
 PcyouNU7PQ/Am2L7gMnTaeuTyf9eVEzsk5cORI6NzvGyZ+ui+sJhNHmZgU0JQppV7Bl1xaB3u
 GSGSsnrd+5520RT9FhlGOfR/R1UkjnWM/QE39DyLVL7dqoqZwHPChRueM510nH/udbHm0sQ1+
 2AQx7MfFnwtPyfZdV23igYikvjZ4QW8X9XAGqXd2d7WBuA7Twin6dmu1yxr6rM8w/qSONh2OP
 lEvcDj4vT7WfCzhBIsPRIdnmsfN2lbp/slrf2KTGV5vmzCrRA0ELwLsMeTdBNFBB1jGnccf9c
 9yEad5eqp7jBVL4mOQpNu7ts0kjPF4h+9U9cGmwJlo/Le2JwQpMd7r3LgLiKlmyabbhnVCQ8f
 wkMmiofqa5FfXzn1OKDYBRRpiiCqn5ubkN/HEGkHVZu6hYT1uR2NF5TvBwbtB6HYOE4UeI1c9
 ajSpH+G1xtP/AJjzGiJiAvbZZiAn/1birGmXyWUiepFLoJxDoha6IZMUmJlCpCsDvVEQJr+sq
 /DRHbzDoeoYcyl6qlpDA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Sun, Feb 21, 2021 at 06:30:10PM -0800, Randy Dunlap wrote:
> Hi,
>
> one spello in 2 locations:
>
> On 2/21/21 7:49 AM, John Wood wrote:
> [...]
> > these statistics dissapear when the involved tasks finished. In this
>
>                    disappear
> [...]
> > + * statistics dissapear when this task is finished. In this scenario =
this data
>
>                  disappear
> [...]

This typos will be corrected in the next version.

Thanks a lot,
John Wood

>
> --
> ~Randy
>
