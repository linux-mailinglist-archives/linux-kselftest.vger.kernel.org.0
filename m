Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B0D33959C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 18:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhCLRzm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 12:55:42 -0500
Received: from mout.gmx.net ([212.227.17.22]:46415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbhCLRzT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 12:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615571687;
        bh=5zvDdlBOTpGmg8SYWvlilFo6X3L3cFtO5aKa0CwJZc4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=H2qPS5OMh+GAQjEPyXw7WHk3to0jYJ7sDl4tsYsXBZIWamCr2BW3Qrbg+JHG7GLpW
         KzhLxagtJzjy1tyniaT4eP/Usxbgx9kB+XdCopLHZovz2yHUieSsG/4+p9nv1FV800
         7A628qswk5DAsHm7U/eRWYrCcxiQIVEVoFFUzPj0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.153]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxUnp-1leElK1mH3-00xtL2; Fri, 12
 Mar 2021 18:54:47 +0100
Date:   Fri, 12 Mar 2021 18:54:44 +0100
From:   John Wood <john.wood@gmx.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <20210312175444.GC3103@ubuntu>
References: <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
 <20210307151920.GR472138@tassilo.jf.intel.com>
 <20210307164520.GA16296@ubuntu>
 <20210307172540.GS472138@tassilo.jf.intel.com>
 <20210307180541.GA17108@ubuntu>
 <20210307224927.GT472138@tassilo.jf.intel.com>
 <20210309184054.GA3058@ubuntu>
 <20210311200517.GG203350@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311200517.GG203350@tassilo.jf.intel.com>
X-Provags-ID: V03:K1:SuNaC8l4ofMz5PeVWxAj2Ub9Iy1nxdyzxd1L6V/gtgj5gnFLD1S
 I5L/bUQtKOVdCBxKBO/ZP7Ncca+0qE8R3yw3fhaopP1rEuS5z8BzijroK8maIG7T6YhP+NZ
 z1VOvu+civtZqHxFIQLRLgTi7vErnDtFx9VwG5ckyMVuHs2NwPNZn2Te+26cCuctNXPpOCW
 9tg918q9c3iomwA9F5b1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2g/OjCOku7o=:a+cdNEVUGAIPK9zpYFpOP9
 TCWcVVVEzGCwEteqlEZcE7eWU/SLIKQHwRiNlS/duxRoTowXyMbY2AbfxUpp7lEImTUiF8WvC
 Ccxpi0oKPnIVJF7ZyexplRm5MsO0HGkA275ksMn92E23nIwzLA+bXIzwwX3CUL3dOBfitpIq+
 cwOhS3UxNcIo8I8oUo+y2KXmOMef/sYHlNKZyyp+oWLcv1T2aHGQJHGU11JEDEXeowj5d18H4
 mkGAuCOCCtCaeiHoaAqr8enyrjp/K3O95QROMvycy1hjBzVRm5dux5b7bDNOGfXN0rahVjamD
 lA4NSYsuwX0DhXIwKdobgJOJ6JwRsu9EJHx9m5iwGvlY+eBNRKgLsuNQ1etPpJqGBDIcLMf1b
 TLALI1YKZaEciWdYO+gUv59qBXbctxwUBfPxvO4MKNJWfm9etplamNUI/xCl1MVs0n1d434h4
 x+BslsfjnmmcFtfB83/3nusuqtL0sDmOkzmPps/53CJw2XZPa0c5Ig6GyvVR99bBxtb823jcR
 ULVMMpVE4ogc0OIPhOpFygvVTIeXQ2HeIh+G2a1ncuPaQLMj4LfwNTBsPRQx/YqKYV3xdKmAz
 KMjQwau3Hn30MVTMR9NUAiihKug/crLomVAW2oM4OWdsbPbP9NlBleIEVNBKXtMPu+EFuEY+k
 30SyxfjHNAk7HAeDi04qnrDt6Ph8NVmi0+lbq/OehAQeJ5OOKNa60YtzLVRQQxu7NXeid8Y/b
 HFIKdUCtfYW1cwDLiFHtHxtBQzKLxXZO0SJPgQG7vvCwcIEBx46/c6xhMC6snSlktztnS44OE
 MPyFUBi2P7FdyycZV+QxmZZB9SlbM1On+dXSO6/1Ltgp60vhRJozmQUyw2D92Izn4t9PafMja
 BvyOzBBZiOelJTgq7PSg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 11, 2021 at 12:05:17PM -0800, Andi Kleen wrote:
>
> Okay but that means that the brute force attack can just continue
> because the attacked daemon will be respawned?
>
> You need some way to stop the respawning, otherwise the
> mitigation doesn't work for daemons.
>
I will work on your solution regarding respawned daemons (use wait*() to i=
nform
userspace that the offending processes killed by the mitigation exited due=
 to
this mitigation -> then the supervisor can adopt their own policy).

>
> -Andi
>

Thank you very much,
John Wood
