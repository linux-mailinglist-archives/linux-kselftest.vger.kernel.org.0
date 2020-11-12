Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF72AFE9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 06:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgKLFjX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 00:39:23 -0500
Received: from namei.org ([65.99.196.166]:52612 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbgKLFAH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 00:00:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AC4xj4d005412;
        Thu, 12 Nov 2020 04:59:45 GMT
Date:   Thu, 12 Nov 2020 15:59:45 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 0/9] Landlock fixes
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.2011121559140.5257@namei.org>
References: <20201111213442.434639-1-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1592972126-1605157185=:5257"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1592972126-1605157185=:5257
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 11 Nov 2020, Mickaël Salaün wrote:

> Hi,
> 
> This patch series fixes some issues and makes the Landlock filesystem
> access-control more consistent and deterministic when stacking multiple
> rulesets.  This is checked by current and new tests.  I also extended
> documentation and example to help users.
> 
> This series can be applied on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/log/?h=landlock_lsm

Actually, given the number of fixes here, please respin so we get a 
cleaner initial PR for Linus.

> 
> Regards,
> 
> Mickaël Salaün (9):
>   landlock: Fix memory allocation error handling
>   landlock: Cosmetic fixes for filesystem management
>   landlock: Enforce deterministic interleaved path rules
>   landlock: Always intersect access rights
>   landlock: Add extra checks when inserting a rule
>   selftests/landlock: Extend layout1.inherit_superset
>   landlock: Clean up get_ruleset_from_fd()
>   landlock: Add help to enable Landlock as a stacked LSM
>   landlock: Extend documentation about limitations
> 
>  Documentation/userspace-api/landlock.rst   |  17 +++
>  samples/landlock/sandboxer.c               |  21 +++-
>  security/landlock/Kconfig                  |   4 +-
>  security/landlock/fs.c                     |  67 +++++-----
>  security/landlock/object.c                 |   5 +-
>  security/landlock/ruleset.c                |  34 ++---
>  security/landlock/syscall.c                |  24 ++--
>  tools/testing/selftests/landlock/fs_test.c | 140 +++++++++++++++++++--
>  8 files changed, 239 insertions(+), 73 deletions(-)
> 
> 
> base-commit: 96b3198c4025c11347651700b77e45a686d78553
> 

-- 
James Morris
<jmorris@namei.org>

--1665246916-1592972126-1605157185=:5257--
