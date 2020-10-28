Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F229D77A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 23:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgJ1WWl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 18:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732654AbgJ1WWY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:22:24 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2DCB20829;
        Wed, 28 Oct 2020 02:47:48 +0000 (UTC)
Date:   Tue, 27 Oct 2020 22:47:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: remove _do_fork() leftovers
Message-ID: <20201027224746.3d599f74@oasis.local.home>
In-Reply-To: <20201027224657.413fd7bd@oasis.local.home>
References: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
        <20201023093523.65c495f8@gandalf.local.home>
        <20201023151243.GA1537@oc3871087118.ibm.com>
        <20201023114948.6900aa68@gandalf.local.home>
        <20201023115111.1c0e8768@gandalf.local.home>
        <cedad9bf-ba6b-78ad-644f-ce5074f2fbed@linuxfoundation.org>
        <20201027224657.413fd7bd@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 27 Oct 2020 22:46:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yep, that was the result of this thread.

And if it's not clear. That thread supersedes this one.

-- Steve
