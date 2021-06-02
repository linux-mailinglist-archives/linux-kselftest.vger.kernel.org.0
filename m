Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D030939954A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jun 2021 23:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFBVSu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Jun 2021 17:18:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFBVSu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Jun 2021 17:18:50 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1AAE219DE;
        Wed,  2 Jun 2021 21:17:04 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 58086118DD;
        Wed,  2 Jun 2021 21:17:02 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id XNqGCU71t2CsMwAALh3uQQ
        (envelope-from <dave@stgolabs.net>); Wed, 02 Jun 2021 21:17:02 +0000
Date:   Wed, 2 Jun 2021 14:16:55 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     =?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 0/2] selftests: futex: Expand futex testing
Message-ID: <20210602211655.a6pejg3kcb7qcvdu@offworld>
References: <20210531165036.41468-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210531165036.41468-1-andrealmeid@collabora.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 31 May 2021, Andr� Almeida wrote:

>This patchset expands test coverage for futex, implementing two new
>selftests: one for testing different types of futexes and one for the
>requeue operation.

So these cases are covered by LTP, but I have no objection for also
having them in the kernel selftests too.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
