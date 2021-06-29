Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906CE3B6EEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jun 2021 09:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhF2HrX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Jun 2021 03:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhF2HrW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Jun 2021 03:47:22 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820BAC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jun 2021 00:44:55 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a133so23082702oib.13
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jun 2021 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zS7KNTV0HyeorkDDGwxB1AV6enuRKzO5rthkhdHIRnY=;
        b=uSmokmsLz+B+iOxV8aEwelfv2pfJtlSo42KCWgs38x7SaC34Hv74EMz5UrBpJD8wKs
         rrXVRAqViQApE7M5p4py7wo+UgimkhTiu7cfQ9QxG+a3P+2XuID1B2QUa6GCnPWftXxj
         yd4AsTRvLJlESSG4ulCIsMZojCKxiwKgWXEYxL/n5hrWjuhRIdjyvMcBsjFPbpF4D5wg
         8euCFOo6YihwU96nx7TIX8hgXPLoO85WOc6UH8zquJ86nMuMCPuqVSzY6eYf2PSQJDf7
         sx0ErYstwFORESJYiwBhzgv+8CCxc6R02A1+TWg8BuzWAf3O5GBp+cghn9h8eEHrhe6v
         oxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zS7KNTV0HyeorkDDGwxB1AV6enuRKzO5rthkhdHIRnY=;
        b=aoMdenLL/Y5fqDEXfxrCFtEktGrpLszQp+zfRkzmN+BQpuhWb+cJOo30c3SRhFW3rs
         5b+ukGBF4OZlSYZyATWF/sVJD6oVvq3bhRodLnKRlc93Bd+jQ4nSBzv8uGl5UUVQf/MY
         1trMTEuhMyvMLVPnWPICP/XvDRyhqenYfTvg8+o7OFLno4291cjHCyPWjNeTZTeu80DW
         1Rt2i7rf+vprZO3/zRxs8Pe5MxPMkfX6b8wqc6VppgiKFF4Z1OpvAaBiOxgsdkShqXCQ
         /JT/y4CTGh3fDco8O55F+3/kYS1BViNpSCPSAaMC+IA+wbSN2tbvpF94kDDq9oQZzPH1
         AkTg==
X-Gm-Message-State: AOAM530XMcolTMUoGDiLJLcx8mDyXPvsUtDk10h1y66q7rfUFkGWWJ7t
        P4avL5z2CdAHx368KyToJF79AGc4jHWqdByvp2U=
X-Google-Smtp-Source: ABdhPJxqGoK0Uax0b14dVEHjTfTgnJp9XmtC8p2B1HMogK4vaMl6JKmqu7wzvvhxz7IeE3swiVR8mio+agCf4cWyOSQ=
X-Received: by 2002:aca:cf57:: with SMTP id f84mr4711654oig.174.1624952694882;
 Tue, 29 Jun 2021 00:44:54 -0700 (PDT)
MIME-Version: 1.0
From:   Grace Mark <markgrace326@gmail.com>
Date:   Tue, 29 Jun 2021 00:44:45 -0700
Message-ID: <CAPuwmVQzAV15mnF2G-2VJpRgB789mwspak78BmWp5t1sO=m=_w@mail.gmail.com>
Subject: $hi
To:     markgrace326@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hello
