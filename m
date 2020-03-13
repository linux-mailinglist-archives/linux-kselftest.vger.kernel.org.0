Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC11184749
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCMMz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 08:55:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55781 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMz2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 08:55:28 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jCjqW-0003KZ-PQ; Fri, 13 Mar 2020 12:55:24 +0000
Date:   Fri, 13 Mar 2020 13:55:23 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>, ard.biesheuvel@linaro.org,
        ardb@kernel.org, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        naresh.kamboju@linaro.org, shuah@kernel.org,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>, hridya@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 3/3] binderfs_test: switch from /dev to /tmp as mountpoint
Message-ID: <20200313125523.f5yfeyslodp4b7vx@wittgenstein>
References: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-3-christian.brauner@ubuntu.com>
 <202003121653.4BC2D43@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202003121653.4BC2D43@keescook>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 12, 2020 at 04:54:25PM -0700, Kees Cook wrote:
> On Thu, Mar 12, 2020 at 02:15:31PM +0100, Christian Brauner wrote:
> > Unprivileged users will be able to create directories in there. The
> > unprivileged test for /dev wouldn't have worked on most systems.
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Seems good. (Though would a dynamic location be better?
> mkstemp()-style?)

Yeah, when I originally wrote binderfs that was really more of a
test-stub than anything else. I'll see if I can switch to something less
hard-coded. :)
