Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2548337EB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Mar 2021 21:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhCKUIn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Mar 2021 15:08:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:58343 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhCKUIX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Mar 2021 15:08:23 -0500
IronPort-SDR: 6ux7mApO6T0UIC2xMvfNfvIy2VBXZoB65X2Defpxhy3sPL1ctqTM+Bcehgbu83BMVG9idfkT/0
 cSxrZCoXx71g==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188829210"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="188829210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 12:08:23 -0800
IronPort-SDR: KjMxJMyU8wBcqzcezN9xDQb+xk6wNl0Cwu+bdMoU7Efbs+0g5YtEQEXOORxIL7v1gEYy3MflXo
 XC0C20dAjegA==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="448398607"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 12:08:13 -0800
Date:   Thu, 11 Mar 2021 12:08:11 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     John Wood <john.wood@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
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
Message-ID: <20210311200811.GH203350@tassilo.jf.intel.com>
References: <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
 <20210307151920.GR472138@tassilo.jf.intel.com>
 <20210307164520.GA16296@ubuntu>
 <20210307172540.GS472138@tassilo.jf.intel.com>
 <20210307180541.GA17108@ubuntu>
 <20210307224927.GT472138@tassilo.jf.intel.com>
 <20210309184054.GA3058@ubuntu>
 <20210311182252.GA3349@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311182252.GA3349@ubuntu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> When a brute force attack is detected through the fork or execve system call,
> all the tasks involved in the attack will be killed with the exception of the
> init task (task with pid equal to zero). Now, and only if the init task is
> involved in the attack, block the fork system call from the init process during
> a user defined time (using a sysctl attribute). This way the brute force attack
> is mitigated and the system does not panic.

That means nobody can log in and fix the system during that time.

Would be better to have that policy in init. Perhaps add some way
that someone doing wait*() can know the exit was due this mitigation
(and not something way) Then they could disable respawning of that daemon.

-Andi
