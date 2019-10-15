Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF2D72C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 12:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfJOKHu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 06:07:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34227 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfJOKHu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 06:07:50 -0400
Received: from [185.81.136.22] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKJk3-0005A2-Nc; Tue, 15 Oct 2019 10:07:47 +0000
Date:   Tue, 15 Oct 2019 12:07:44 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christian Kellner <ckellner@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pidfd: add tests for NSpid info in fdinfo
Message-ID: <20191015100743.t6gowsic7c347ldv@wittgenstein>
References: <20191011122323.7770-1-ckellner@redhat.com>
 <20191014162034.2185-1-ckellner@redhat.com>
 <20191014162034.2185-2-ckellner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191014162034.2185-2-ckellner@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 14, 2019 at 06:20:33PM +0200, Christian Kellner wrote:
> From: Christian Kellner <christian@kellner.me>
> 
> Add a test that checks that if pid namespaces are configured the fdinfo
> file of a pidfd contains an NSpid: entry containing the process id in
> the current and additionally all nested namespaces. In the case that
> a pidfd is from a pid namespace not in the same namespace hierarchy as
> the process accessing the fdinfo file, ensure the 'NSpid' shows 0 for
> that pidfd, analogous to the 'Pid' entry.
> 
> Signed-off-by: Christian Kellner <christian@kellner.me>

That looks reasonable to me.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
