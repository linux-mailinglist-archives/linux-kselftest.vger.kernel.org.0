Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9301F55D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgFJNcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 09:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgFJNcK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 09:32:10 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE61E2067B;
        Wed, 10 Jun 2020 13:32:08 +0000 (UTC)
Date:   Wed, 10 Jun 2020 09:32:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
Message-ID: <20200610093206.5b9fb1b7@oasis.local.home>
In-Reply-To: <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
        <159115203782.70027.2241223276591824366.stgit@devnote2>
        <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
        <20200610145535.747d2765d60e6e3923441768@kernel.org>
        <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 10 Jun 2020 06:04:33 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > Steve, what would you think?
> >   
> 
> No worries. As far as kselftest tree is concrned, I can apply these
> after rc1 comes out with Tom's patch.
> 
> Or I can give Ack and Steve can take these through tracing tree.

All my patches have already made it to Linus's tree. Perhaps
cherry-pick the commit needed from Linus's tree (it shouldn't break
anything when Linus pulls it). Just let Linus know what you did, and
everything should be fine.

-- Steve
