Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC7E82E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2019 09:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfJ2IAf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Oct 2019 04:00:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:42020 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfJ2IAe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Oct 2019 04:00:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 30A994FA;
        Tue, 29 Oct 2019 08:00:30 +0000 (UTC)
Date:   Tue, 29 Oct 2019 02:00:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
Message-ID: <20191029020027.516a6bce@lwn.net>
In-Reply-To: <20191029003120.llve32crfw63ovpw@mail.google.com>
References: <20191020131717.28990-1-changbin.du@gmail.com>
        <20191024121940.1d6a64df@lwn.net>
        <87woctb9cj.fsf@intel.com>
        <20191025144802.uixg2crhw6h7gghq@mail.google.com>
        <87v9s99q9l.fsf@intel.com>
        <20191029003120.llve32crfw63ovpw@mail.google.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 29 Oct 2019 08:31:22 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> Here python is different from C. Both empty string and None are False in python.
> Note such condition is common in python.

Treating both as a False value is reasonably common.  Treating them
elsewhere in the same code block as separate values is less
so; that's the part I would prefer to avoid.

Thanks,

jon
