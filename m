Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BAE326EA6
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Feb 2021 19:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhB0Sqo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Feb 2021 13:46:44 -0500
Received: from mout.gmx.net ([212.227.15.15]:52737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhB0Sqn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Feb 2021 13:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614451481;
        bh=15q3zwQ7cXEwZeNdqHUiaEAspocOc5rXPvRSWa6sL0I=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GqjcLDSZuVJIlH8V10wsmypH7mdJN7DsaNa9PWZdywDW/WSY9s385W5Uhotb4ZEpY
         zmBmiUx6s7ydAjj8aRv/AXNoZojSUVdnIQHF6/087w6lj/2+SEL4h1aOwLdvMF8IBd
         VI6EpZ6Wgf0LrL1lN+LxvO5oHg0XcQ7P/MSaafLA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3bWr-1lxl5H3u4Z-010Yzv; Sat, 27
 Feb 2021 19:44:41 +0100
Date:   Sat, 27 Feb 2021 19:44:28 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 0/8] Fork brute force attack mitigation
Message-ID: <20210227184428.GA9641@ubuntu>
References: <20210227153013.6747-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210227153013.6747-1-john.wood@gmx.com>
X-Provags-ID: V03:K1:RoCE3t5+RrvW/W5eGj27hzaWflBslhjVVtsFIKNqkbkQmcLC2L/
 JKPCs+sCtzvo1yQ7WkQ4O2ZuFVdkW17mFu2Spbbz666AzrOelM+keM36YiUDKplAQIjHuTA
 XY1JJAh7Fq45WPG/mvy/uwa8V5dxooxqEasasLp8UpEErZUX5mD5jy8CUK7ccBc6t/oNuzg
 N4cn3mIAUoKYCHRl5cp6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H1SqB/m8Fz0=:MV6jGMgavPZGgJlR+YHYNE
 YfkE53PFuIg6og8pJvKwLVJtbP+6ajscZ4GWZW5xUU7toarjg+RkfgzUe9A4UBnuIkZqER/hY
 2ahputXjZEggdiLozJArcHU2KLkurD59GUqwM5mB2UP5p5Fu5lZpb/NfuJ4inqVQOF/ek+t/U
 mAQ06S6THWxbqWI4R+aGf3JBuBsGq2qlcSVc6Lpi/QjJ+yXsmgYwbpNUlRRmJISoPW+oUrIIq
 YeBDYh+zm6IC2ZoAlSzc4y9KDjDHEZdjKe5x7FrWhZcAJ4ETP8VOgIA/OZeJEdok29dCpOjcs
 Bvzff6soW2RDio/kNLrm8OhMeCKr3T/V8bNTyKseLTuAnvg0oZNvC3sM7d6sXbtxOhSfqIqJU
 z5o8qPQXVGb7jxfLfgduRzFKwDZ/ia9q1XASb9qFNB+SofBgbwlA0cUgAnpEXfwEwnfWd7hEK
 68vNGsb6RyVlZrG964dOdTqoVWKtEj5uLsHFXzrHRHD7txd/EOObvMFEPB+c5FVe2qRsIG3KE
 MD8NpC2TqWRu3ZWxMfuEKZRPRVLEFI3D0KT5fLrFCFhkMn91mGh5VktVUWp0BrZldftt3jYts
 e20BzJYhtVnjeFVr2+TuxREplAYpAskY+KQUK14g/2CIpUgD60MB+FaYcssvXvu2c0dZxM6JA
 V1//sMgJuuGbRMNF0PVmTNUkHzTF8HkAcfnpNNRrKGVCfyWwflLP2bHCltT6T8jrKXIc3IzN0
 7ai1j9Tpv2ltVN7IvieYZPpx8MEeOkAQH50jlrIt+UhYweyfG1A3416pYPrNo7O7/9CNsUJhy
 U6vYboqtSZYlFW4NGo3y4xwacpHMKWaoFyzDdGZXQpOCRKOHjnWndtiN3SC1D0IzO/issNrB5
 Z9il+GbiAQc4cZm2nOdg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Feb 27, 2021 at 04:30:05PM +0100, John Wood wrote:
>
> This patch serie is a task of the KSPP [1] and can also be accessed from=
 my
> github tree [2] in the "brute_v4" branch.

Sorry. The correct branch is "brute_v5".
Apologies.

John Wood
>
> [1] https://github.com/KSPP/linux/issues/39
> [2] https://github.com/johwood/linux/
>
