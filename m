Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4B433FEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 22:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJSUuu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 16:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhJSUuu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 16:50:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1288261355;
        Tue, 19 Oct 2021 20:48:35 +0000 (UTC)
Date:   Tue, 19 Oct 2021 16:48:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/5] tracing: Add support for creating hist trigger
 variables from literal
Message-ID: <20211019164834.465b2a53@gandalf.local.home>
In-Reply-To: <20210915195306.612966-2-kaleshsingh@google.com>
References: <20210915195306.612966-1-kaleshsingh@google.com>
        <20210915195306.612966-2-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Sep 2021 19:52:45 +0000
Kalesh Singh <kaleshsingh@google.com> wrote:

> Currently hist trigger expressions don't support the use of numeric
> literals:
> 	e.g. echo 'hist:keys=common_pid:x=$y-1234'
> 		--> is not valid expression syntax  
> 
> Having the ability to use numeric constants in hist triggers supports
> a wider range of expressions for creating variables.

I'm not against the patch, but I'm curious to what use case this would be
useful for. In the cover letter it mentions the division and multiplication
for finding associated buckets, but what is the addition / subtraction used
for?

-- Steve


> 
> Add support for creating trace event histogram variables from numeric
> literals.
> 
> 	e.g. echo 'hist:keys=common_pid:x=1234,y=size-1024' >> event/trigger
> 
> A negative numeric constant is created, using unary minus operator
> (parentheses are required).
> 
> 	e.g. echo 'hist:keys=common_pid:z=-(2)' >> event/trigger
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
