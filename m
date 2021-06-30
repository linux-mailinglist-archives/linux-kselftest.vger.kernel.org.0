Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A013B8273
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 14:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhF3MyN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 08:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234760AbhF3MyM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 08:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625057503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pUwuLQkHGleranaAqRZINrmMOJUNb/vIt0E3wrINEn4=;
        b=UEWrn6F1BCVDqfv4drM1k7iuzOWnDRbk+v2Ytv5h1B0MfPGL43Ks71gllnDn4oa7m6Iv4g
        +PtEGpSFEFrZ7SUNf8CZRPVB72nRo9oGiy8/gSHU0C778rEelA7azqqMj0T+8VZyxujE5e
        a0GNKsWhubN/pD6KjpFtiL+el11OlSE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-_oEBVsVkNBW2nm4oNefLXA-1; Wed, 30 Jun 2021 08:51:39 -0400
X-MC-Unique: _oEBVsVkNBW2nm4oNefLXA-1
Received: by mail-wm1-f71.google.com with SMTP id g141-20020a1c9d930000b02901edd380b6a7so465539wme.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 05:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pUwuLQkHGleranaAqRZINrmMOJUNb/vIt0E3wrINEn4=;
        b=tRaZDuSaAPGS15+2QmWVkbQe/SyJ6ojwNWgG+oUENhN7OS++xr517iWuMPd7fyfl8E
         Ov2YPjdqNmU9gcNv9M2cahbaeQkHyx5XTm7O9FLyy+ySYBqghdfddFdX4T9s8S+8tDxs
         iOcEBGdtP3N6hUZzPtmd1QZQ4o1jXMCUKruSlyPUPzHjpsJe8ijL0Y2ia+CrdNkBp5tI
         gtrJr2lzR6smflCuXxpBVS2XfUl8COKaNmIUSWUPP+e81FiRo3ZX+IlZ4Wbfwrf43xEn
         NAWjRlywxsJXdpAxWmcKd61KG8gMcDJIuxMyT1sOfSdCmZH+L7t1LCWU3MBfFapF+nvr
         +LjA==
X-Gm-Message-State: AOAM531lWK6kM+WZiHLVwspGT71Yk3vmY+7mQhNGrIkj5HvlvmK3wBSB
        hNeSgEhDcVQy/RgFAjfmLeuxwFSauQ32FuewfPhUvfEddwiuIJaiNSdy1m+Nr+I4pjjVo4d+mQ2
        HO+z88hRATdfBbF2WlYIM0SaadWPV
X-Received: by 2002:a05:6000:2a8:: with SMTP id l8mr31013578wry.186.1625057498649;
        Wed, 30 Jun 2021 05:51:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+A3cam/HOx08iR4Dgv1xrR3kZ30JXTfJVYpXahcrk9aqIEZWxlvu4eDhsY8miyyLf1GrLkA==
X-Received: by 2002:a05:6000:2a8:: with SMTP id l8mr31013568wry.186.1625057498525;
        Wed, 30 Jun 2021 05:51:38 -0700 (PDT)
Received: from pc-23.home (2a01cb058d44a7001b6d03f4d258668b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d44:a700:1b6d:3f4:d258:668b])
        by smtp.gmail.com with ESMTPSA id g17sm17307986wrw.31.2021.06.30.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:51:38 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:51:36 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/4] selftests: forwarding: Tests redirects between
 L3 and L2 devices
Message-ID: <cover.1625056665.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following merge commit 8eb517a2a4ae ("Merge branch 'reset-mac'"), which
made several L3 tunnels reset the skb's mac header pointer after decap,
here's a selftest that validates this new behaviour.

Patch 1 adds a reusable script for setting up the base network and
tests ipip and gre tunnels. The following patches extend the selftest
to cover more tunnel types (sit, ip6gre, ip6tnl, vxlan-gpe and
bareudp).

Guillaume Nault (4):
  selftests: forwarding: Test redirecting gre or ipip packets to
    Ethernet
  selftests: forwarding: Test redirecting sit packets to Ethernet
  selftests: forwarding: Test redirecting ip6gre and ip6tnl packets to
    Ethernet
  selftests: forwarding: Test redirecting vxlan and bareudp packets to
    Ethernet

 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/config |   7 +
 .../net/forwarding/tc_redirect_l2l3.sh        | 438 ++++++++++++++++++
 .../net/forwarding/topo_nschain_lib.sh        | 267 +++++++++++
 4 files changed, 713 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
 create mode 100644 tools/testing/selftests/net/forwarding/topo_nschain_lib.sh

-- 
2.21.3

