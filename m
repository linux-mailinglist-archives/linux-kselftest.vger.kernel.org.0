Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D81F7684
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 12:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFLKM1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 06:12:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:53612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgFLKM0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 06:12:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 433A4B162;
        Fri, 12 Jun 2020 10:12:29 +0000 (UTC)
Date:   Fri, 12 Jun 2020 12:12:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/livepatch: use $(dmesg --notime) instead
 of manually filtering
Message-ID: <20200612101224.GG4311@linux-b0ei>
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
 <20200610172101.21910-3-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610172101.21910-3-joe.lawrence@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2020-06-10 13:21:00, Joe Lawrence wrote:
> The dmesg utility already comes with a command line switch to omit
> kernel timestamps, let's use it instead of applying an extra regex to
> filter them out.
> 
> Now without the '[timestamp]: ' prefix at the beginning of the log
> entry, revise the filtering regex to search for the 'livepatch:'
> subsystem prefix at the beginning of the line.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Nice simplification.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
