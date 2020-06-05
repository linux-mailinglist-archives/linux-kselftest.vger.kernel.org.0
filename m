Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11801EF874
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgFEM7V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 08:59:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgFEM7U (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 08:59:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 044DAACAE;
        Fri,  5 Jun 2020 12:59:21 +0000 (UTC)
Date:   Fri, 5 Jun 2020 14:59:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yannick Cote <ycote@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com, linux-kernel@vger.kernel.org,
        mbenes@suse.cz, kamalesh@linux.vnet.ibm.com
Subject: Re: [PATCH v2 3/4] selftests/livepatch: more verification in
 test-klp-shadow-vars
Message-ID: <20200605125917.GB5099@linux-b0ei>
References: <20200603182058.109470-1-ycote@redhat.com>
 <20200603182058.109470-4-ycote@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603182058.109470-4-ycote@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2020-06-03 14:20:57, Yannick Cote wrote:
> This change makes the test feel more familiar with narrowing to a
> typical usage by operating on a number of identical structure instances
> and populating the same two new shadow variables symmetrically while
> keeping the same testing and verification criteria for the extra
> variables.
> 
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Yannick Cote <ycote@redhat.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
