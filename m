Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678BD7600A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 22:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGXUqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 16:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGXUqV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 16:46:21 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA4919A;
        Mon, 24 Jul 2023 13:46:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1912360171;
        Mon, 24 Jul 2023 22:46:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690231574; bh=UB7XrkLxSAviUP2YZJLF5m+KmTIyWfsCFgfZtdJNAF4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uedqM8rjavbXaNVw2tF6Dqc5FN5DQBXWhPNInvFMlDOXgDiMqcCVu75CdwYUjz2da
         4nt2aQLZd8SMoVqKyLwkPVGBiqMxH3MOwhepxO2rtCJC6jdErkjMEifH3VeuoMMeSA
         Kwdso1tuteEq+4fXcEvUfg/mHvkweu+/GlhRGVIyrRzFJq/Rux7fnK4kSxXMuAgRGu
         fmLHZwB7qyF28oqyscCHmk2+4C46PyxM6v4SEXjVeV+7SJtTN4btqm1FvPLkVRyFfZ
         2nj4TNvNJPu1d2D4ZM2i7B8S0bY+H+CEtgObA9yOD0K31ffkr65GxPXI2LafK12TVq
         hiLiX3bRF4uDA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zARXmQVOazi2; Mon, 24 Jul 2023 22:46:10 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id F05AA6016E;
        Mon, 24 Jul 2023 22:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690231570; bh=UB7XrkLxSAviUP2YZJLF5m+KmTIyWfsCFgfZtdJNAF4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wGBpGKZmsSyviT4pMejrbT5xl8jLvvtrwrWpG9Sf+ZthDdhQZioiYAzAAW/JecL+G
         pQZR+JC3vJNKO1hL0EFf78/+GO1NnKaG377EyfomafeNeRPD3TgA6thmvdRAl6rQ4V
         KxP2uLWoGqId7yodPH9WCbUkslL81Dr996lQoJmzUf3FOhZp0HLf3MvYGx+In5iCPd
         sgEqWez613YuD+FOVsblyb7oBUYhdd9u24Z7yP0Q+3FMxvmtH5QC0CqhlhUjcrkcz+
         x3z9bsBz0+wguZFG+nlcQRxUm48Zh2k4JjmTXNu8cZIyg25ekN8vfaGswQsdmv7Vfb
         AwUCdc/1wqAFw==
Message-ID: <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
Date:   Mon, 24 Jul 2023 22:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
Content-Language: en-US
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZL6OljQubhVtQjcD@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/24/23 16:45, Ido Schimmel wrote:
> On Sun, Jul 23, 2023 at 11:37:46PM +0200, Mirsad Todorovac wrote:
>> Some tests however exited with error:

Hi,

>> marvin@defiant:~/linux/kernel/linux_torvalds$ grep "not ok" ../kselftest-6.5-rc2-net-forwarding-11.log
>> not ok 3 selftests: net/forwarding: bridge_mdb.sh # exit=1
>> not ok 5 selftests: net/forwarding: bridge_mdb_max.sh # exit=1
>> not ok 11 selftests: net/forwarding: bridge_vlan_mcast.sh # exit=1
> 
> I can't reproduce these three.

I have now enabled 'set -x' and here is the link to the output.

NOTE as there are side-effects to running the test scripts, I have ran the
whole suite, just in case:

https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/kselftest-6.5-rc3-net-forwarding-12.log.xz

> Do you have systemd-networkd running?

No:

● defiant
     State: running
      Jobs: 0 queued
    Failed: 0 units
     Since: Mon 2023-07-24 18:52:51 CEST; 3h 45min ago
    CGroup: /
            ├─user.slice
            │ └─user-1000.slice
            │   ├─user@1000.service
            │   │ ├─session.slice
            │   │ │ ├─org.gnome.SettingsDaemon.MediaKeys.service
            │   │ │ │ └─3137 /usr/libexec/gsd-media-keys
            │   │ │ ├─org.gnome.SettingsDaemon.Smartcard.service
            │   │ │ │ └─3157 /usr/libexec/gsd-smartcard
            │   │ │ ├─org.gnome.SettingsDaemon.Datetime.service
            │   │ │ │ └─3131 /usr/libexec/gsd-datetime
            │   │ │ ├─xdg-document-portal.service
            │   │ │ │ ├─2799 /usr/libexec/xdg-document-portal
            │   │ │ │ └─2809 fusermount3 -o rw,nosuid,nodev,fsname=portal,auto_unmount,subtype=portal -- /run/user/1000/doc
            │   │ │ ├─org.gnome.SettingsDaemon.Housekeeping.service
            │   │ │ │ └─3132 /usr/libexec/gsd-housekeeping
            │   │ │ ├─xdg-desktop-portal.service
            │   │ │ │ └─3277 /usr/libexec/xdg-desktop-portal
            │   │ │ ├─org.freedesktop.IBus.session.GNOME.service
            │   │ │ │ ├─3126 sh -c /usr/bin/ibus-daemon --panel disable $([ "$XDG_SESSION_TYPE" = "x11" ] && echo "--xim")
            │   │ │ │ ├─3130 /usr/bin/ibus-daemon --panel disable
            │   │ │ │ ├─3229 /usr/libexec/ibus-dconf
            │   │ │ │ ├─3237 /usr/libexec/ibus-extension-gtk3
            │   │ │ │ └─3295 /usr/libexec/ibus-engine-simple
            │   │ │ ├─org.gnome.SettingsDaemon.Keyboard.service
            │   │ │ │ └─3136 /usr/libexec/gsd-keyboard
            │   │ │ ├─pipewire-media-session.service
            │   │ │ │ └─2751 /usr/bin/pipewire-media-session
            │   │ │ ├─org.gnome.SettingsDaemon.A11ySettings.service
            │   │ │ │ └─3127 /usr/libexec/gsd-a11y-settings
            │   │ │ ├─pulseaudio.service
            │   │ │ │ └─2752 /usr/bin/pulseaudio --daemonize=no --log-target=journal
            │   │ │ ├─org.gnome.SettingsDaemon.Wacom.service
            │   │ │ │ └─3161 /usr/libexec/gsd-wacom
            │   │ │ ├─org.gnome.SettingsDaemon.Sharing.service
            │   │ │ │ └─3156 /usr/libexec/gsd-sharing
            │   │ │ ├─org.gnome.SettingsDaemon.Color.service
            │   │ │ │ └─3128 /usr/libexec/gsd-color
            │   │ │ ├─org.gnome.SettingsDaemon.ScreensaverProxy.service
            │   │ │ │ └─3155 /usr/libexec/gsd-screensaver-proxy
            │   │ │ ├─org.gnome.SettingsDaemon.PrintNotifications.service
            │   │ │ │ ├─3143 /usr/libexec/gsd-print-notifications
            │   │ │ │ └─3290 /usr/libexec/gsd-printer
            │   │ │ ├─org.gnome.SettingsDaemon.Power.service
            │   │ │ │ └─3141 /usr/libexec/gsd-power
            │   │ │ ├─org.gnome.Shell@wayland.service
            │   │ │ │ ├─  2988 /usr/bin/gnome-shell
            │   │ │ │ └─414067 gjs /usr/share/gnome-shell/extensions/ding@rastersoft.com/ding.js -E -P /usr/share/gnome-shell/extensions/ding@rastersoft.com -M 0 -D 0:>
            │   │ │ ├─org.gnome.SettingsDaemon.Sound.service
            │   │ │ │ └─3159 /usr/libexec/gsd-sound
            │   │ │ ├─pipewire.service
            │   │ │ │ └─2750 /usr/bin/pipewire
            │   │ │ └─org.gnome.SettingsDaemon.Rfkill.service
            │   │ │   └─3148 /usr/libexec/gsd-rfkill
            │   │ ├─background.slice
            │   │ │ └─tracker-miner-fs-3.service
            │   │ │   └─2830 /usr/libexec/tracker-miner-fs-3
            │   │ ├─app.slice
            │   │ │ ├─speech-dispatcher.service
            │   │ │ │ ├─210924 /usr/bin/speech-dispatcher -s -t 0
            │   │ │ │ ├─210940 /usr/lib/speech-dispatcher-modules/sd_espeak-ng /etc/speech-dispatcher/modules/espeak-ng.conf
            │   │ │ │ └─210943 /usr/lib/speech-dispatcher-modules/sd_dummy /etc/speech-dispatcher/modules/dummy.conf
            │   │ │ ├─app-gnome-firefox-209967.scope
            │   │ │ │ ├─209967 /usr/lib/firefox/firefox
            │   │ │ │ ├─210044 /usr/lib/firefox/firefox -contentproc -parentBuildID 20230710165010 -prefsLen 30997 -prefMapSize 236126 -appDir /usr/lib/firefox/browser>
            │   │ │ │ ├─210071 /usr/lib/firefox/firefox -contentproc -childID 1 -isForBrowser -prefsLen 31138 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 2023>
            │   │ │ │ ├─210161 /usr/lib/firefox/firefox -contentproc -childID 2 -isForBrowser -prefsLen 36726 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 2023>
            │   │ │ │ ├─210248 /usr/lib/firefox/firefox -contentproc -parentBuildID 20230710165010 -prefsLen 36767 -prefMapSize 236126 -appDir /usr/lib/firefox/browser>
            │   │ │ │ ├─210249 /usr/lib/firefox/firefox -contentproc -parentBuildID 20230710165010 -sandboxingKind 0 -prefsLen 36767 -prefMapSize 236126 -appDir /usr/l>
            │   │ │ │ ├─210274 /usr/lib/firefox/firefox -contentproc -childID 4 -isForBrowser -prefsLen 31117 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 2023>
            │   │ │ │ ├─210278 /usr/lib/firefox/firefox -contentproc -childID 5 -isForBrowser -prefsLen 31117 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 2023>
            │   │ │ │ ├─210281 /usr/lib/firefox/firefox -contentproc -childID 6 -isForBrowser -prefsLen 31117 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 2023>
            │   │ │ │ ├─210291 /usr/lib/firefox/firefox -contentproc -childID 7 -isForBrowser -prefsLen 31117 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 2023>
            │   │ │ │ ├─210418 /usr/lib/firefox/firefox -contentproc -childID 8 -isForBrowser -prefsLen 31117 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 2023>
            │   │ │ │ ├─210468 /usr/lib/firefox/firefox -contentproc -childID 9 -isForBrowser -prefsLen 31117 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 2023>
            │   │ │ │ ├─210471 /usr/lib/firefox/firefox -contentproc -childID 10 -isForBrowser -prefsLen 31117 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─210612 /usr/lib/firefox/firefox -contentproc -childID 12 -isForBrowser -prefsLen 31221 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─210652 /usr/lib/firefox/firefox -contentproc -childID 13 -isForBrowser -prefsLen 31221 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─210728 /usr/lib/firefox/firefox -contentproc -childID 15 -isForBrowser -prefsLen 31221 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─210767 /usr/lib/firefox/firefox -contentproc -childID 16 -isForBrowser -prefsLen 31221 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─210887 /usr/lib/firefox/firefox -contentproc -childID 18 -isForBrowser -prefsLen 31221 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─211762 /usr/lib/firefox/firefox -contentproc -childID 37 -isForBrowser -prefsLen 31221 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─211942 /usr/lib/firefox/firefox -contentproc -childID 39 -isForBrowser -prefsLen 31221 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─212135 /usr/lib/firefox/firefox -contentproc -childID 43 -isForBrowser -prefsLen 31221 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─242515 /usr/lib/firefox/firefox -contentproc -childID 70 -isForBrowser -prefsLen 31221 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 202>
            │   │ │ │ ├─311393 /usr/lib/firefox/firefox -contentproc -childID 108 -isForBrowser -prefsLen 31270 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 20>
            │   │ │ │ ├─414504 /usr/lib/firefox/firefox -contentproc -childID 205 -isForBrowser -prefsLen 31270 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 20>
            │   │ │ │ ├─414929 /usr/lib/firefox/firefox -contentproc -childID 214 -isForBrowser -prefsLen 31270 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 20>
            │   │ │ │ ├─415065 /usr/lib/firefox/firefox -contentproc -childID 217 -isForBrowser -prefsLen 31270 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 20>
            │   │ │ │ ├─415153 /usr/lib/firefox/firefox -contentproc -childID 218 -isForBrowser -prefsLen 31327 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 20>
            │   │ │ │ ├─415194 /usr/lib/firefox/firefox -contentproc -childID 219 -isForBrowser -prefsLen 31327 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 20>
            │   │ │ │ └─415241 /usr/lib/firefox/firefox -contentproc -childID 220 -isForBrowser -prefsLen 31327 -prefMapSize 236126 -jsInitLen 240908 -parentBuildID 20>
            │   │ │ ├─app-gnome-update\x2dnotifier-4388.scope
            │   │ │ │ └─4388 update-notifier
            │   │ │ ├─gvfs-goa-volume-monitor.service
            │   │ │ │ └─2848 /usr/libexec/gvfs-goa-volume-monitor
            │   │ │ ├─xdg-permission-store.service
            │   │ │ │ └─2803 /usr/libexec/xdg-permission-store
            │   │ │ ├─app-gnome-org.gnome.Evolution\x2dalarm\x2dnotify-3203.scope
            │   │ │ │ └─3203 /usr/libexec/evolution-data-server/evolution-alarm-notify
            │   │ │ ├─evolution-calendar-factory.service
            │   │ │ │ └─3054 /usr/libexec/evolution-calendar-factory
            │   │ │ ├─xdg-desktop-portal-gnome.service
            │   │ │ │ └─3282 /usr/libexec/xdg-desktop-portal-gnome
            │   │ │ ├─dconf.service
            │   │ │ │ └─3045 /usr/libexec/dconf-service
            │   │ │ ├─app-gnome\x2dsession\x2dmanager.slice
            │   │ │ │ └─gnome-session-manager@ubuntu.service
            │   │ │ │   └─2967 /usr/libexec/gnome-session-binary --systemd-service --session=ubuntu
            │   │ │ ├─gvfs-daemon.service
            │   │ │ │ ├─  2773 /usr/libexec/gvfsd
            │   │ │ │ ├─  2778 /usr/libexec/gvfsd-fuse /run/user/1000/gvfs -f
            │   │ │ │ ├─  3075 /usr/libexec/gvfsd-trash --spawner :1.2 /org/gtk/gvfs/exec_spaw/0
            │   │ │ │ ├─415094 /usr/libexec/gvfsd-network --spawner :1.2 /org/gtk/gvfs/exec_spaw/1
            │   │ │ │ └─415114 /usr/libexec/gvfsd-dnssd --spawner :1.2 /org/gtk/gvfs/exec_spaw/3
            │   │ │ ├─evolution-source-registry.service
            │   │ │ │ └─3043 /usr/libexec/evolution-source-registry
            │   │ │ ├─gvfs-udisks2-volume-monitor.service
            │   │ │ │ └─2835 /usr/libexec/gvfs-udisks2-volume-monitor
            │   │ │ ├─snap.snapd-desktop-integration.snapd-desktop-integration.service
            │   │ │ │ ├─3408 /snap/snapd-desktop-integration/83/usr/bin/snapd-desktop-integration
            │   │ │ │ └─3486 /snap/snapd-desktop-integration/83/usr/bin/snapd-desktop-integration
            │   │ │ ├─app-gnome-thunderbird-247930.scope
            │   │ │ │ ├─247930 /usr/lib/thunderbird/thunderbird
            │   │ │ │ └─248039 /usr/lib/thunderbird/thunderbird -contentproc -childID 1 -isForBrowser -prefsLen 11247 -prefMapSize 234029 -jsInitLen 277276 -parentBuil>
            │   │ │ ├─app-gnome-at\x2dspi\x2ddbus\x2dbus-2987.scope
            │   │ │ │ ├─2987 /usr/libexec/at-spi-bus-launcher --launch-immediately
            │   │ │ │ ├─2999 /usr/bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-address 11 --address=unix:path=/run/use>
            │   │ │ │ └─3091 /usr/libexec/at-spi2-registryd --use-gnome-session
            │   │ │ ├─app-org.gnome.Terminal.slice
            │   │ │ │ ├─vte-spawn-206cdf5a-0844-40f4-bde4-2795906ecfbf.scope
            │   │ │ │ │ ├─415133 bash
            │   │ │ │ │ ├─415265 systemctl status
            │   │ │ │ │ └─415266 pager
            │   │ │ │ ├─vte-spawn-1cee6c96-97c6-49f7-87b8-56316324bc9d.scope
            │   │ │ │ │ ├─259808 bash
            │   │ │ │ │ └─259849 ssh mtodorov@orion.grf.unizg.hr
            │   │ │ │ ├─vte-spawn-227851cc-18ba-495a-8614-bd7b6988cd46.scope
            │   │ │ │ │ └─4233 bash
            │   │ │ │ ├─vte-spawn-8e1d0389-31ab-4a66-ba0f-19f3b652e825.scope
            │   │ │ │ │ ├─251437 bash
            │   │ │ │ │ └─251459 ssh mtodorov@magrf.grf.unizg.hr
            │   │ │ │ ├─gnome-terminal-server.service
            │   │ │ │ │ └─3527 /usr/libexec/gnome-terminal-server
            │   │ │ │ └─vte-spawn-fe998971-59c0-419a-ae1c-4d74c2fe9e24.scope
            │   │ │ │   └─3553 bash
            │   │ │ ├─gvfs-gphoto2-volume-monitor.service
            │   │ │ │ └─2844 /usr/libexec/gvfs-gphoto2-volume-monitor
            │   │ │ ├─gnome-session-monitor.service
            │   │ │ │ └─2946 /usr/libexec/gnome-session-ctl --monitor
            │   │ │ ├─xdg-desktop-portal-gtk.service
            │   │ │ │ └─3340 /usr/libexec/xdg-desktop-portal-gtk
            │   │ │ ├─gvfs-metadata.service
            │   │ │ │ └─3396 /usr/libexec/gvfsd-metadata
            │   │ │ ├─dbus.service
            │   │ │ │ ├─  2766 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
            │   │ │ │ ├─  2852 /usr/libexec/goa-daemon
            │   │ │ │ ├─  2859 /usr/libexec/goa-identity-service
            │   │ │ │ ├─  3037 /usr/libexec/gnome-shell-calendar-server
            │   │ │ │ ├─  3089 /usr/bin/gjs /usr/share/gnome-shell/org.gnome.Shell.Notifications
            │   │ │ │ ├─  3244 /usr/libexec/ibus-portal
            │   │ │ │ ├─  3306 /usr/bin/gjs /usr/share/gnome-shell/org.gnome.ScreenSaver
            │   │ │ │ └─233902 /usr/bin/gedit --gapplication-service
            │   │ │ ├─evolution-addressbook-factory.service
            │   │ │ │ └─3065 /usr/libexec/evolution-addressbook-factory
            │   │ │ ├─gvfs-mtp-volume-monitor.service
            │   │ │ │ └─2840 /usr/libexec/gvfs-mtp-volume-monitor
            │   │ │ ├─app-gnome-org.gnome.SettingsDaemon.DiskUtilityNotify-3218.scope
            │   │ │ │ └─3218 /usr/libexec/gsd-disk-utility-notify
            │   │ │ └─gvfs-afc-volume-monitor.service
            │   │ │   └─2861 /usr/libexec/gvfs-afc-volume-monitor
            │   │ └─init.scope
            │   │   ├─2743 /lib/systemd/systemd --user
            │   │   └─2744 (sd-pam)
            │   └─session-2.scope
            │     ├─  2731 gdm-session-worker [pam/gdm-password]
            │     ├─  2762 /usr/bin/gnome-keyring-daemon --daemonize --login
            │     ├─  2890 /usr/libexec/gdm-wayland-session env GNOME_SHELL_SESSION_MODE=ubuntu /usr/bin/gnome-session --session=ubuntu
            │     ├─  2893 /usr/libexec/gnome-session-binary --session=ubuntu
            │     └─251933 /usr/bin/ssh-agent -D -a /run/user/1000/keyring/.ssh
            ├─init.scope
            │ └─1 /sbin/init splash
            └─system.slice
              ├─irqbalance.service
              │ └─1282 /usr/sbin/irqbalance --foreground
              ├─haveged.service
              │ └─1110 /usr/sbin/haveged --Foreground --verbose=1
              ├─packagekit.service
              │ └─2503 /usr/libexec/packagekitd
              ├─systemd-udevd.service
              │ └─609 /lib/systemd/systemd-udevd
              ├─cron.service
              │ └─1270 /usr/sbin/cron -f -P
              ├─polkit.service
              │ └─1289 /usr/libexec/polkitd --no-debug
              ├─networkd-dispatcher.service
              │ └─1285 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
              ├─rtkit-daemon.service
              │ └─2306 /usr/libexec/rtkit-daemon
              ├─accounts-daemon.service
              │ └─1263 /usr/libexec/accounts-daemon
              ├─mcollective.service
              │ └─1402 ruby /usr/sbin/mcollectived --config=/etc/mcollective/server.cfg --pidfile=/var/run/mcollective.pid --no-daemonize
              ├─wpa_supplicant.service
              │ └─1309 /sbin/wpa_supplicant -u -s -O /run/wpa_supplicant
              ├─ModemManager.service
              │ └─1389 /usr/sbin/ModemManager
              ├─systemd-journald.service
              │ └─579 /lib/systemd/systemd-journald
              ├─power-profiles-daemon.service
              │ └─1293 /usr/libexec/power-profiles-daemon
              ├─unattended-upgrades.service
              │ └─1415 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
              ├─ssh.service
              │ └─1431 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
              ├─colord.service
              │ └─2665 /usr/libexec/colord
              ├─NetworkManager.service
              │ └─1276 /usr/sbin/NetworkManager --no-daemon
              ├─snapd.service
              │ └─1300 /usr/lib/snapd/snapd
              ├─gdm.service
              │ └─2245 /usr/sbin/gdm3
              ├─switcheroo-control.service
              │ └─1301 /usr/libexec/switcheroo-control
              ├─rsyslog.service
              │ └─1294 /usr/sbin/rsyslogd -n -iNONE
              ├─snap.canonical-livepatch.canonical-livepatchd.service
              │ └─1406 /snap/canonical-livepatch/235/canonical-livepatchd
              ├─kerneloops.service
              │ ├─2191 /usr/sbin/kerneloops --test
              │ └─2202 /usr/sbin/kerneloops
              ├─cups-browsed.service
              │ └─2163 /usr/sbin/cups-browsed
              ├─smartmontools.service
              │ └─1297 /usr/sbin/smartd -n
              ├─cups.service
              │ └─1401 /usr/sbin/cupsd -l
              ├─pcscd.service
              │ └─2600 /usr/sbin/pcscd --foreground --debug
              ├─upower.service
              │ └─2461 /usr/libexec/upowerd
              ├─systemd-oomd.service
              │ └─1122 /lib/systemd/systemd-oomd
              ├─systemd-resolved.service
              │ └─1124 /lib/systemd/systemd-resolved
              ├─udisks2.service
              │ └─1308 /usr/libexec/udisks2/udisksd
              ├─acpid.service
              │ └─1264 /usr/sbin/acpid
              ├─ntp.service
              │ └─1424 /usr/sbin/ntpd -p /var/run/ntpd.pid -g -u 130:138
              ├─dbus.service
              │ └─1273 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
              ├─avahi-daemon.service
              │ ├─1268 avahi-daemon: running [defiant.local]
              │ └─1314 avahi-daemon: chroot helper
              └─systemd-logind.service
                └─1305 /lib/systemd/systemd-logind


> If so, by default it tries to
> take over interfaces unless you tell it not to. For example, on my
> system I have:
> 
> $ cat /etc/systemd/network/10-ignore.link
> [Match]
> OriginalName=*
> 
> [Link]
> MACAddressPolicy=none
> 
> This tells systemd not to assign a persistent MAC address on virtual
> interfaces.
> 
> And (redacted):
> 
> $ cat /etc/systemd/network/80-dhcp.network
> [Match]
> ...
> 
> This tells systemd to only manage the interfaces matching the match
> criteria and ignore the rest.

I didn't see how could I adjust this to my configuration, but I had some dayjob
tasks, too ...

>> not ok 15 selftests: net/forwarding: ethtool_extended_state.sh # exit=1
>> not ok 17 selftests: net/forwarding: ethtool.sh # exit=1
>> not ok 25 selftests: net/forwarding: hw_stats_l3_gre.sh # exit=1
> 
> Fixed these three.
> 
>> not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1
> 
> Fixed.

Great job, that's almost 50% of them!

>> not ok 80 selftests: net/forwarding: tc_actions.sh # exit=1
>> not ok 83 selftests: net/forwarding: tc_flower.sh # exit=1
>> not ok 84 selftests: net/forwarding: tc_flower_l2_miss.sh # exit=1
>> not ok 89 selftests: net/forwarding: tc_tunnel_key.sh # exit=1
> 
> Can't reproduce these.

Hope the above will help.

> Pushed the fixes on top of the fixes from yesterday:
> 
> https://github.com/idosch/linux/commits/submit/sefltests_fix_v1

I have applied them.

BTW, after running the full net/forwarding test suite, "ip link show"
looks like this:

marvin@defiant:~/linux/kernel/linux_torvalds$ ip link show
256: veth7@veth6: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether 16:74:e0:e6:f0:92 brd ff:ff:ff:ff:ff:ff
257: veth6@veth7: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether 22:f3:40:50:fb:73 brd ff:ff:ff:ff:ff:ff
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
     link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
3: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 10000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether b6:46:e6:4c:e4:00 brd ff:ff:ff:ff:ff:ff
4: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 2000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether 2e:ff:7f:8a:6b:d4 brd ff:ff:ff:ff:ff:ff
5: veth3@veth2: <BROADCAST,MULTICAST,M-DOWN> mtu 10000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether ba:33:37:81:dc:5b brd ff:ff:ff:ff:ff:ff
6: veth2@veth3: <BROADCAST,MULTICAST,M-DOWN> mtu 2000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether f2:fd:0a:9b:94:17 brd ff:ff:ff:ff:ff:ff
278: veth9@veth8: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether 0a:f1:22:04:0f:55 brd ff:ff:ff:ff:ff:ff
279: veth8@veth9: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether 92:be:71:00:59:0f brd ff:ff:ff:ff:ff:ff
282: gre0@NONE: <NOARP> mtu 1476 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/gre 0.0.0.0 brd 0.0.0.0
283: gretap0@NONE: <BROADCAST,MULTICAST> mtu 1462 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
284: erspan0@NONE: <BROADCAST,MULTICAST> mtu 1450 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
366: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/tunnel6 :: brd :: permaddr ce1e:75f3:f565::
367: ip6gre0@NONE: <NOARP> mtu 1448 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/gre6 :: brd :: permaddr 1e91:da47:154d::
237: veth5@veth4: <BROADCAST,MULTICAST,M-DOWN> mtu 2000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether 6a:e3:dc:ad:8c:a0 brd ff:ff:ff:ff:ff:ff
238: veth4@veth5: <BROADCAST,MULTICAST,M-DOWN> mtu 10000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether ce:a7:61:90:c8:2d brd ff:ff:ff:ff:ff:ff
marvin@defiant:~/linux/kernel/linux_torvalds$

This is kinda awkward, because I have to reboot the machine for the next run, each time.

I am in no condition to try to figure out which tests leaked links.

I will leave the machine on in case you need additional diagnostics.

Thanks.

Kind regards,
Mirsad
