Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773AC4070F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Sep 2021 20:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhIJSe4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Sep 2021 14:34:56 -0400
Received: from ipmail05.adl3.internode.on.net ([150.101.137.13]:41807 "EHLO
        ipmail05.adl3.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhIJSe4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Sep 2021 14:34:56 -0400
X-SMTP-MATCH: 1
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A1vUHYq0Csw06EVCJPFXoFQqjBL4kLtp133?=
 =?us-ascii?q?Aq2lEZdPRUGvb1qynIpoV+6faUskd1ZJhOo7u90cW7K080sKQV3WBzB8bBYO?=
 =?us-ascii?q?CFghrKEGgK1+KL/9SjIU3DH4VmupuIHZISNDS9NzZHsfo=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DGAQAIpDthAKWPfAENTR4BAQsSDEA?=
 =?us-ascii?q?JinuCXqw3CwFSBAEBhHMCgkMmOBMBAgQVAQEGAQEBAQEGBBABPVaMOAIBAyN?=
 =?us-ascii?q?WEAsNAQwCGQ0CAlcGDoJ2s3l6gTEbZ4gUgWOBECqBZYd/hBg3gVVEgRUnDw2?=
 =?us-ascii?q?CNzA+hCIBASCDFzaCDCIEiXOBWqB0nHQtB4MugTEGC50iLINUARGLZ4YrA4t?=
 =?us-ascii?q?dhS2GeZFBpTKBfTMaLm8Bgj9Qjn+OKYEcAgYLAQEDCY9mXgEB?=
Received: from unknown (HELO [127.0.0.1]) ([1.124.143.165])
  by ipmail05.adl3.internode.on.net with ESMTP; 11 Sep 2021 04:03:39 +0930
Date:   Sat, 11 Sep 2021 04:03:37 +0930
From:   Arthur Marsh <arthur.marsh@internode.on.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_After_KUnit_update_for_Linux_5=2E15-rc1_?= =?US-ASCII?Q?-_unable_to_share_VFAT_filesystem_via_samba?=
User-Agent: K-9 Mail for Android
In-Reply-To: <f1d84102-6edf-271f-52f9-0d4bbc85c0c7@linuxfoundation.org>
References: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net> <f1d84102-6edf-271f-52f9-0d4bbc85c0c7@linuxfoundation.org>
Message-ID: <C1ACE9E0-2EDF-4F55-A6F1-B9143F62514B@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>Can you send your config and dmesg? This will help determine if
>KUNIT is enabled - it shouldn't be.

# CONFIG_KUNIT is not set

I am re-running the git-bisect without the " - - fs/fat" qualifier but it will take a few days.

Arthur. 
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
