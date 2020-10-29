Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8685829E1BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 03:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgJ2CDD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 22:03:03 -0400
Received: from namei.org ([65.99.196.166]:38520 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgJ1Vsr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 17:48:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 09S5TZBd026933;
        Wed, 28 Oct 2020 05:29:35 GMT
Date:   Wed, 28 Oct 2020 16:29:35 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v22 05/12] LSM: Infrastructure management of the
 superblock
In-Reply-To: <20201027200358.557003-6-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.2010281628570.25689@namei.org>
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-6-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-514386363-1603862978=:25689"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-514386363-1603862978=:25689
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 27 Oct 2020, Mickaël Salaün wrote:

> From: Casey Schaufler <casey@schaufler-ca.com>
> 
> Move management of the superblock->sb_security blob out of the
> individual security modules and into the security infrastructure.
> Instead of allocating the blobs from within the modules, the modules
> tell the infrastructure how much space is required, and the space is
> allocated there.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

It would be good to see review from JJ here.

-- 
James Morris
<jmorris@namei.org>

--1665246916-514386363-1603862978=:25689--
