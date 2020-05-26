Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427211E2753
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgEZQoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 12:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgEZQoI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 12:44:08 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2241A20723;
        Tue, 26 May 2020 16:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590511448;
        bh=uF8fArU4V3d0gRDmpvRFyjvlsGovSmDM0Tikgs5AV38=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uoD034meFsUWPg/ub4LFxiQAsudQfzkCzZs8FxcyEtzwsloP+zD8WyCaY1nzXqoXP
         4S+EhrAruBA651BrPiGTsvSknZPN3X1vX/ZGlIFbpWnmOkCtXll1ZtNyLxMXRA6pfM
         rX8Z+Z9rqhBvAl03zvkKf2voyxYgmgXK3J6ufm+4=
Subject: Re: OUTPUT and TEST_CUSTOM_PROGS
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <xuny367osf2z.fsf@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <c049c93e-d962-ac15-e623-34df9af10a8b@kernel.org>
Date:   Tue, 26 May 2020 10:43:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xuny367osf2z.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/25/20 12:28 AM, Yauheni Kaliuta wrote:
> Hi!
> 
> lib.mk expects TEST_GEN_PROGS, TEST_GEN_PROGS_EXTENDED and
> TEST_GEN_FILES to be in local directory and tries to handle out
> of tree build adding OUTPUT to it at the beginning.
> 
> commit be16a244c199 ("selftests: lib.mk: add TEST_CUSTOM_PROGS to
> allow custom test run/install") adds TEST_CUSTOM_PROGS but it
> handles it differently. Should it add OUTPUT as well?
> 

Individual tests apply OUTPUT to TEST_CUSTOM_PROGS. lib.mk rules
can't build TEST_CUSTOM_PROGS and it is left up to tests to
handle them as custom.

So no on adding OUTPUT to TEST_CUSTOM_PROGS in lib.mk.

thanks,
-- Shuah
