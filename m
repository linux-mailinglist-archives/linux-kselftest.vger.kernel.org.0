Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A71F6A23
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgFKOgW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 10:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbgFKOgW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 10:36:22 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E77206C3;
        Thu, 11 Jun 2020 14:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591886181;
        bh=3odZMer00sE/n4jCKTZHS4GFSMcNc1Rw3n8kkCHJfEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aFgE3zp3Wr0SKQ/LfsNkmxoBBhaGtaXYxpzQcgggDRA+d8qLmt8LEEQdKdGgkNP8d
         i37NA0C3UdreAWUYguOQ4Rgn2WHWlotx8N9Wy8qC2JAlS8fr8BECuinP2D6/yXboeI
         HYhsk+KMIIsh+fheB99/2qCIah17m1lZ8HusoMLQ=
Date:   Thu, 11 Jun 2020 23:36:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
Message-Id: <20200611233617.2dc66dec28e6aef848352700@kernel.org>
In-Reply-To: <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
        <159115203782.70027.2241223276591824366.stgit@devnote2>
        <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
        <20200610145535.747d2765d60e6e3923441768@kernel.org>
        <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
        <20200610093206.5b9fb1b7@oasis.local.home>
        <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 11 Jun 2020 06:03:50 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 6/10/20 7:32 AM, Steven Rostedt wrote:
> > On Wed, 10 Jun 2020 06:04:33 -0600
> > Shuah Khan <skhan@linuxfoundation.org> wrote:
> > 
> >>> Steve, what would you think?
> >>>    
> >>
> >> No worries. As far as kselftest tree is concrned, I can apply these
> >> after rc1 comes out with Tom's patch.
> >>
> >> Or I can give Ack and Steve can take these through tracing tree.
> > 
> > All my patches have already made it to Linus's tree. Perhaps
> > cherry-pick the commit needed from Linus's tree (it shouldn't break
> > anything when Linus pulls it). Just let Linus know what you did, and
> > everything should be fine.
> > 
> 
> Good to know. I will get these in.

Thanks Shuah and Steve!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
