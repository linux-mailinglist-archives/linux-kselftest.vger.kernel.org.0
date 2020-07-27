Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B272422EAF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jul 2020 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgG0LQd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jul 2020 07:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgG0LQc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jul 2020 07:16:32 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1682420663;
        Mon, 27 Jul 2020 11:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595848592;
        bh=huU9FrrRSkbKfoK/WI/8ojDrsG1FAaBqigpZCvBwXX8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GCy8ebTiS11gvztCsOHteRvKuVdxOKytVP0wMGyEh5vdqaOd8NK9tESxZvfTF+Lmi
         0QPQrPJQGjkiOMAFKl2spUTQyH5dnXdz77bGmfSaKVc5xwfqC4HaetSeihngkfD/bf
         El2EDPh+zLuWgzunDco7HVeJJH+fXwkaQUY2+Cko=
Message-ID: <1595848589.4841.78.camel@kernel.org>
Subject: Re: [PATCH v3 00/19] Introduce partial kernel_read_file() support
From:   Mimi Zohar <zohar@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Jul 2020 07:16:29 -0400
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> v3:
> - add reviews/acks
> - add "IMA: Add support for file reads without contents" patch
> - trim CC list, in case that's why vger ignored v2
> v2: [missing from lkml archives! (CC list too long?) repeating changes here]
> - fix issues in firmware test suite
> - add firmware partial read patches
> - various bug fixes/cleanups
> v1: https://lore.kernel.org/lkml/20200717174309.1164575-1-keescook@chromium.org/
> 
> Hi,
> 
> Here's my tree for adding partial read support in kernel_read_file(),
> which fixes a number of issues along the way. It's got Scott's firmware
> and IMA patches ported and everything tests cleanly for me (even with
> CONFIG_IMA_APPRAISE=y).

Thanks, Kees.  Other than my comments on the new
security_kernel_post_load_data() hook, the patch set is really nice.

In addition to compiling with CONFIG_IMA_APPRAISE enabled, have you
booted the kernel with the ima_policy=tcb?  The tcb policy will add
measurements to the IMA measurement list and extend the TPM with the
file or buffer data digest.  Are you seeing the firmware measurements,
in particular the partial read measurement?

thanks,

Mimi
